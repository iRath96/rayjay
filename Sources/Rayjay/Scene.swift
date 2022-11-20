import Foundation

public enum SceneError: Error {
    case missingDecodingConfiguration
}

extension Decoder {
    var configuration: Scene.DecodingConfiguration {
        get throws {
            guard let configuration = userInfo[.init(rawValue: "configuration")!] as? Scene.DecodingConfiguration else {
                throw SceneError.missingDecodingConfiguration
            }
            return configuration
        }
    }
}

public struct Scene: Codable, DecodableWithConfiguration, Equatable {
    public struct DecodingConfiguration {
        private let baseURL: URL?
        private let nodeKernels: [String: any NodeKernel.Type]
        private let lightKernels: [String: any LightKernel.Type]
        
        public init(baseURL: URL?, nodeKernels: [any NodeKernel.Type], lightKernels: [any LightKernel.Type]) {
            self.baseURL = baseURL
            self.nodeKernels = .init(uniqueKeysWithValues: nodeKernels.map { ($0.id, $0) })
            self.lightKernels = .init(uniqueKeysWithValues: lightKernels.map { ($0.id, $0) })
        }
        
        func resolve(path: String) -> URL {
            return URL(fileURLWithPath: path, relativeTo: baseURL).absoluteURL
        }
        
        func nodeKernel(key: String) -> (any NodeKernel.Type)? {
            return self.nodeKernels[key]
        }
        
        func lightKernel(key: String) -> (any LightKernel.Type)? {
            return self.lightKernels[key]
        }
    }
    
    public var materials: [String: Material]
    public var lights: [String: Light]
    public var shapes: [String: Shape]
    public var entities: [String: Entity]
    public var camera: Camera?
    public var render: RenderSettings
    
    public init(from decoder: Decoder, configuration: DecodingConfiguration) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        materials = try container.decode(type(of: materials), forKey: .materials, configuration: configuration)
        lights = try container.decode(type(of: lights), forKey: .lights, configuration: configuration)
        shapes = try container.decode(type(of: shapes), forKey: .shapes, configuration: configuration)
        entities = try container.decode(type(of: entities), forKey: .entities)
        camera = try container.decodeIfPresent(Camera.self, forKey: .camera)
        render = try container.decode(type(of: render), forKey: .render)
    }
    
    public init(from decoder: Decoder) throws {
        guard let configuration = decoder.userInfo[.init(rawValue: "configuration")!] as? DecodingConfiguration else {
            throw SceneError.missingDecodingConfiguration
        }
        try self.init(from: decoder, configuration: configuration)
    }
}
