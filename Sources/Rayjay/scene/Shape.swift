import Foundation

public struct Shape: Encodable, DecodableWithConfiguration, Equatable {
    public typealias DecodingConfiguration = Scene.DecodingConfiguration
    
    public var type: String
    public var filepath: URL
    public var materials: [String]
    
    public init(type: String, filepath: URL, materials: [String]) {
        self.type = type
        self.filepath = filepath
        self.materials = materials
    }
    
    public init(from decoder: Decoder, configuration: DecodingConfiguration) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(String.self, forKey: .type)
        self.materials = try container.decode([String].self, forKey: .materials)
        
        let path = try container.decode(String.self, forKey: .filepath)
        self.filepath = configuration.resolve(path: path)
    }
}
