import Foundation

extension OptionSet {
    mutating func set(_ member: Element, enabled: Bool) {
        if enabled {
            self.update(with: member)
        } else {
            self.remove(member)
        }
    }
}

public struct Visibility: OptionSet, Codable, Equatable {
    public let rawValue: Int
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    public static let camera = Self(rawValue: 1 << 0)
    public static let diffuse = Self(rawValue: 1 << 1)
    public static let glossy = Self(rawValue: 1 << 2)
    public static let transmission = Self(rawValue: 1 << 3)
    public static let volume = Self(rawValue: 1 << 4)
    public static let shadow = Self(rawValue: 1 << 5)
    
    public static let all: Self = [.camera, .diffuse, .glossy, .transmission, .volume, .shadow]
    public static let none: Self = []
    
    private enum CodingKeys: CodingKey {
        case camera, diffuse, glossy, transmission, volume, shadow
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.contains(.camera), forKey: .camera)
        try container.encode(self.contains(.diffuse), forKey: .diffuse)
        try container.encode(self.contains(.glossy), forKey: .glossy)
        try container.encode(self.contains(.transmission), forKey: .transmission)
        try container.encode(self.contains(.volume), forKey: .volume)
        try container.encode(self.contains(.shadow), forKey: .shadow)
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self = .none
        set(.camera, enabled: try container.decode(Bool.self, forKey: .camera))
        set(.diffuse, enabled: try container.decode(Bool.self, forKey: .diffuse))
        set(.glossy, enabled: try container.decode(Bool.self, forKey: .glossy))
        set(.transmission, enabled: try container.decode(Bool.self, forKey: .transmission))
        set(.volume, enabled: try container.decode(Bool.self, forKey: .volume))
        set(.shadow, enabled: try container.decode(Bool.self, forKey: .shadow))
    }
}
