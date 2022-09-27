import Foundation

public struct Material: Encodable, DecodableWithConfiguration, Equatable {
    public typealias DecodingConfiguration = Node.DecodingConfiguration
    
    public var nodes: [String: Node]
    
    public init(nodes: [String : Node]) {
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
}
