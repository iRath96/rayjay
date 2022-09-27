import Foundation

public enum SceneError: Error {
    case missingDecodingConfiguration
}

public struct Scene: Codable, DecodableWithConfiguration, Equatable {
    public struct DecodingConfiguration {
        let nodeKernels: [any NodeKernel.Type]
        let lightKernels: [any LightKernel.Type]
    }
    
    public var materials: [String: Material]
    public var lights: [String: Light]
    public var shapes: [String: Shape]
    public var entities: [String: Entity]
    public var camera: Camera?
    public var render: RenderSettings
    
    public init(from decoder: Decoder, configuration: DecodingConfiguration) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        materials = try container.decode(type(of: materials), forKey: .materials, configuration: .init(configuration.nodeKernels))
        lights = try container.decode(type(of: lights), forKey: .lights, configuration: .init(configuration.lightKernels))
        shapes = try container.decode(type(of: shapes), forKey: .shapes)
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
