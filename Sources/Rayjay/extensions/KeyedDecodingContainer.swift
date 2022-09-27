import Foundation

struct JSONCodingKeys: CodingKey {
    var stringValue: String
    init?(stringValue: String) {
        self.stringValue = stringValue
    }

    var intValue: Int?
    init?(intValue: Int) {
        self.init(stringValue: "\(intValue)")
        self.intValue = intValue
    }
}

extension KeyedDecodingContainer {
    public func decode<T>(
        _: [String: T].Type,
        forKey key: KeyedDecodingContainer<K>.Key,
        configuration: T.DecodingConfiguration
    ) throws -> [String: T] where T : DecodableWithConfiguration {
        let container = try nestedContainer(keyedBy: JSONCodingKeys.self, forKey: key)
        return Dictionary(uniqueKeysWithValues: try container.allKeys.map { key in
            (key.stringValue, try container.decode(T.self, forKey: key, configuration: configuration))
        })
    }
}
