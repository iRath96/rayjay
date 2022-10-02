import Foundation

public struct Material: Encodable, DecodableWithConfiguration, Equatable {
    public typealias DecodingConfiguration = Node.DecodingConfiguration
    
    public var nodes: [String: Node]
    
    public init(nodes: [String: Node]) {
        self.nodes = nodes
    }
    
    public init(from decoder: Decoder, configuration: DecodingConfiguration) throws {
        let container = try decoder.container(keyedBy: JSONCodingKeys.self)
        self.nodes = try Dictionary(uniqueKeysWithValues: container.allKeys.map { key in
            (key.stringValue, try container.decode(Node.self, forKey: key, configuration: configuration))
        })
    }
    
    public func encode(to encoder: Encoder) throws {
        try nodes.encode(to: encoder)
    }
    
    public var activeOutput: Node? {
        nodes.values.first(where: {
            $0.kernel is OutputMaterialKernel ||
            $0.kernel is OutputLightKernel ||
            $0.kernel is OutputWorldKernel
        })
    }
    
    private func foldConstants(input: Node.Input, fallback: Node.Value) -> Node.Value {
        guard let link = input.links?[0] else {
            return input.value ?? fallback
        }
        
        let node = nodes[link.node]!
        switch node.kernel {
        case let kernel as ValueKernel:
            return .scalar(kernel.value)
        default:
            return fallback
        }
    }
    
    private func hasSurfaceEmission(link: Node.Link?) -> Bool {
        guard let link = link else {
            return false
        }
        
        let node = nodes[link.node]!
        switch node.kernel {
        case is AddShaderKernel:
            return node.inputs.contains(where: {
                ($0.value.links?.contains(where: hasSurfaceEmission)) ?? false
            })
        case is MixShaderKernel:
            let fac = foldConstants(
                input: node.inputs["Fac"]!,
                fallback: .scalar(0.5)).scalarValue
            
            var activeLinks: [Node.Link?] = []
            if fac < 1 {
                activeLinks.append(contentsOf: node.inputs["Shader"]!.links ?? [])
            }
            if fac > 0 {
                activeLinks.append(contentsOf: node.inputs["Shader.001"]!.links ?? [])
            }
            return activeLinks.contains(where: hasSurfaceEmission)
        case is EmissionKernel:
            let strength = foldConstants(
                input: node.inputs["Strength"]!,
                fallback: .scalar(1)).scalarValue
            let color = foldConstants(
                input: node.inputs["Color"]!,
                fallback: .vector([ 1, 1, 1 ])).vectorValue
            return strength != 0 && color.contains(where: { $0 != 0 })
        case is BsdfPrincipledKernel:
            let strength = foldConstants(
                input: node.inputs["Emission Strength"]!,
                fallback: .scalar(1)).scalarValue
            let color = foldConstants(
                input: node.inputs["Emission"]!,
                fallback: .vector([ 1, 1, 1 ])).vectorValue
            return strength != 0 && color.contains(where: { $0 != 0 })
        case is BsdfAnisotropicKernel,
            is BsdfDiffuseKernel,
            is BsdfGlassKernel,
            is BsdfGlossyKernel,
            is BsdfRefractionKernel,
            is BsdfTranslucentKernel,
            is BsdfTransparentKernel:
            return false
        default:
            /// must be conservative
            return true
        }
    }
    
    public func hasSurfaceEmission() -> Bool {
        guard let output = self.activeOutput else {
            return false
        }
        
        let links = output.inputs["Surface"]?.links ?? []
        return links.contains(where: hasSurfaceEmission)
    }
}
