import Foundation
import simd

public struct Entity: Codable, Equatable {
    public var shape: String
    public var visibility: Visibility
    public var matrix: float4x4
    
    public init(shape: String, visibility: Visibility, matrix: float4x4) {
        self.shape = shape
        self.visibility = visibility
        self.matrix = matrix
    }
    
    private enum CodingKeys: String, CodingKey {
        case shape
        case visibility
        case matrix
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        shape = try container.decode(String.self, forKey: .shape)
        visibility = try container.decode(Visibility.self, forKey: .visibility)
        
        let matrixEntries = try container.decode([Float].self, forKey: .matrix)
        matrix = float4x4()
        for y in 0..<4 {
            for x in 0..<4 {
                matrix[x, y] = matrixEntries[4 * y + x]
            }
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(shape, forKey: .shape)
        try container.encode(visibility, forKey: .visibility)
        
        var matrixEntries: [Float] = .init(repeating: 0, count: 16)
        for y in 0..<4 {
            for x in 0..<4 {
                matrixEntries[4 * y + x] = matrix[x, y]
            }
        }
        try container.encode(matrixEntries, forKey: .matrix)
    }
}
