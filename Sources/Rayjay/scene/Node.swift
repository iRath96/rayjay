import Foundation

public protocol NodeKernel: Codable, Equatable {
    static var id: String { get }
}

public enum NodeError: Error {
    case unsupportedNodeType(String)
}

public struct Node: Encodable, DecodableWithConfiguration, Equatable {
    public typealias DecodingConfiguration = Scene.DecodingConfiguration
    
    public struct Link: Codable, Equatable {
        public var node: String
        public var property: String
        
        public init(from decoder: Decoder) throws {
            var unkeyed = try decoder.unkeyedContainer()
            self.node = try unkeyed.decode(String.self)
            self.property = try unkeyed.decode(String.self)
        }
        
        public func encode(to encoder: Encoder) throws {
            var unkeyed = encoder.unkeyedContainer()
            try unkeyed.encode(self.node)
            try unkeyed.encode(self.property)
        }
        
        public init(node: String, property: String) {
            self.node = node
            self.property = property
        }
    }
    
    public enum Value: Codable, Equatable {
        case scalar(Float)
        case vector([Float])
        case string(String)
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            do {
                self = .scalar(try container.decode(Float.self))
            } catch {
                do {
                    self = .vector(try container.decode([Float].self))
                } catch {
                    self = .string(try container.decode(String.self))
                }
            }
        }
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .scalar(let a0): try container.encode(a0)
            case .vector(let a0): try container.encode(a0)
            case .string(let a0): try container.encode(a0)
            }
        }
        
        public var scalarValue: Float {
            switch self {
            case .scalar(let v): return v
            case .vector(let v): return v.reduce(0, +) / Float(v.count)
            case .string: return 0
            }
        }
        
        public var vectorValue: [Float] {
            switch self {
            case .scalar(let v): return [ v ]
            case .vector(let v): return v
            case .string: return [ 0 ]
            }
        }
    }
    
    public struct Input: Codable, Equatable {
        public var type: String
        public var links: [Link]?
        public var value: Value?
        
        public init(type: String, links: [Node.Link]? = nil, value: Node.Value? = nil) {
            self.type = type
            self.links = links
            self.value = value
        }
        
        public static func scalar(_ scalar: Float) -> Self {
            return .init(type: "VALUE", value: .scalar(scalar))
        }
        
        public static func vector(_ vector: [Float]) -> Self {
            return .init(type: "VECTOR", value: .vector(vector))
        }
        
        public static func shader() -> Self {
            return .init(type: "SHADER")
        }
        
        public static func shader(_ node: String, _ property: String) -> Self {
            return .init(type: "SHADER", links: [.init(node: node, property: property)])
        }
    }
    
    private enum CodingKeys: CodingKey {
        case type
        case inputs
        case parameters
    }
    
    public var inputs: [String: Input]
    public var kernel: any NodeKernel
    
    public init(inputs: [String: Node.Input], kernel: any NodeKernel) {
        self.inputs = inputs
        self.kernel = kernel
    }
    
    public init(from decoder: Decoder, configuration: DecodingConfiguration) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        
        guard let type = configuration.nodeKernel(key: type) else {
            throw NodeError.unsupportedNodeType(type)
        }
        
        inputs = try container.decode([String: Input].self, forKey: .inputs)
        kernel = try container.decode(type, forKey: .parameters)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type(of: kernel).id, forKey: .type)
        try container.encode(inputs, forKey: .inputs)
        try kernel.encode(to: container.superEncoder(forKey: .parameters))
    }
    
    public static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.inputs == rhs.inputs &&
            equals(lhs.kernel, rhs.kernel)
    }
}
