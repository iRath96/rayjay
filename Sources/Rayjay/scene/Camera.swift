import Foundation
import simd

public struct Camera: Codable, Equatable {
    public struct Film: Codable, Equatable {
        var width: Float
        var height: Float
    }
    
    public struct DepthOfField: Codable, Equatable {
        var focus: Float
        var fstop: Float
    }
    
    public var nearClip: Float
    public var farClip: Float
    public var film: Film
    public var transform: float4x4
    public var depthOfField: DepthOfField?
    
    public init(nearClip: Float, farClip: Float, film: Camera.Film, transform: float4x4, depthOfField: Camera.DepthOfField? = nil) {
        self.nearClip = nearClip
        self.farClip = farClip
        self.film = film
        self.transform = transform
        self.depthOfField = depthOfField
    }
    
    private enum CodingKeys: String, CodingKey {
        case nearClip = "near_clip"
        case farClip = "far_clip"
        case film
        case transform
        case depthOfField = "dof"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        nearClip = try container.decode(Float.self, forKey: .nearClip)
        farClip = try container.decode(Float.self, forKey: .farClip)
        film = try container.decode(Film.self, forKey: .film)
        depthOfField = try container.decodeIfPresent(DepthOfField.self, forKey: .depthOfField)
        
        let matrixEntries = try container.decode([Float].self, forKey: .transform)
        transform = float4x4()
        for y in 0..<4 {
            for x in 0..<4 {
                transform[x, y] = matrixEntries[4 * y + x]
            }
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(nearClip, forKey: .nearClip)
        try container.encode(farClip, forKey: .farClip)
        try container.encode(film, forKey: .film)
        try container.encodeIfPresent(depthOfField, forKey: .depthOfField)
        
        var matrixEntries: [Float] = .init(repeating: 0, count: 16)
        for y in 0..<4 {
            for x in 0..<4 {
                matrixEntries[4 * y + x] = transform[x, y]
            }
        }
        try container.encode(matrixEntries, forKey: .transform)
    }
}
