import Foundation

public struct Shape: Codable, Equatable {
    public var type: String
    public var filepath: URL
    public var materials: [String]
    
    public init(type: String, filepath: URL, materials: [String]) {
        self.type = type
        self.filepath = filepath
        self.materials = materials
    }
}
