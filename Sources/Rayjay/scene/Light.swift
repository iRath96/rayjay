import Foundation

public protocol LightKernel: Codable, Equatable {
    static var id: String { get }
}

public enum LightError: Error {
    case unsupportedLightType(String)
}

public func equals(_ lhs: Any, _ rhs: Any) -> Bool {
    func open<A: Equatable>(_ lhs: A, _ rhs: Any) -> Bool {
        lhs == (rhs as? A)
    }

    guard let lhs = lhs as? any Equatable
    else { return false }
    
    return open(lhs, rhs)
}

public struct Light: Encodable, DecodableWithConfiguration, Equatable {
    public typealias DecodingConfiguration = Scene.DecodingConfiguration
    
    public var material: String
    public var visibility: Visibility
    public var castShadows: Bool
    public var useMIS: Bool
    public var kernel: any LightKernel
    
    public init(material: String, visibility: Visibility, castShadows: Bool, useMIS: Bool, kernel: any LightKernel) {
        self.material = material
        self.visibility = visibility
        self.castShadows = castShadows
        self.useMIS = useMIS
        self.kernel = kernel
    }
    
    private enum CodingKeys: CodingKey {
        case type
        case material
        case visibility, cast_shadows, use_mis
        case parameters
    }
    
    public init(from decoder: Decoder, configuration: DecodingConfiguration) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        
        guard let type = configuration.lightKernel(key: type) else {
            throw LightError.unsupportedLightType(type)
        }
        
        material = try container.decode(String.self, forKey: .material)
        visibility = try container.decode(Visibility.self, forKey: .visibility)
        castShadows = try container.decode(Bool.self, forKey: .cast_shadows)
        useMIS = try container.decode(Bool.self, forKey: .use_mis)
        kernel = try container.decode(type, forKey: .parameters)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type(of: kernel).id, forKey: .type)
        try container.encode(material, forKey: .material)
        try container.encode(visibility, forKey: .visibility)
        try container.encode(castShadows, forKey: .cast_shadows)
        try container.encode(useMIS, forKey: .use_mis)
        try kernel.encode(to: container.superEncoder(forKey: .parameters))
    }
    
    public static func == (lhs: Light, rhs: Light) -> Bool {
        return lhs.material == rhs.material &&
            lhs.visibility == rhs.visibility &&
            lhs.castShadows == rhs.castShadows &&
            lhs.useMIS == rhs.useMIS &&
            equals(lhs.kernel, rhs.kernel)
    }
}
