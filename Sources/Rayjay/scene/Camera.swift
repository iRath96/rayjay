import Foundation
import simd

public struct Camera: Codable, Equatable {
    public struct Film: Codable, Equatable {
        public var width: Float
        public var height: Float
    }
    
    public struct DepthOfField: Codable, Equatable {
        public var focus: Float
        public var fstop: Float
    }
    
    public var type: String
    public var nearClip: Float
    public var farClip: Float
    public var film: Film
    public var transform: float4x4
    public var shift: simd_float2
    public var depthOfField: DepthOfField?
    
    public var scale: Float? // for orthographic cameras
    public var focalLength: Float? // for perspective cameras
    
    public init(
        type: String,
        nearClip: Float, farClip: Float,
        film: Camera.Film, transform: float4x4, shift: simd_float2,
        depthOfField: Camera.DepthOfField? = nil,
        scale: Float? = nil, focalLength: Float? = nil
    ) {
        self.type = type
        self.nearClip = nearClip
        self.farClip = farClip
        self.film = film
        self.transform = transform
        self.shift = shift
        self.depthOfField = depthOfField
        self.scale = scale
        self.focalLength = focalLength
    }
    
    private enum CodingKeys: String, CodingKey {
        case type = "type"
        case nearClip = "near_clip"
        case farClip = "far_clip"
        case film
        case transform
        case shift
        case depthOfField = "dof"
        case scale
        case focalLength = "focal_length"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        nearClip = try container.decode(Float.self, forKey: .nearClip)
        farClip = try container.decode(Float.self, forKey: .farClip)
        film = try container.decode(Film.self, forKey: .film)
        shift = try container.decode(simd_float2.self, forKey: .shift)
        depthOfField = try container.decodeIfPresent(DepthOfField.self, forKey: .depthOfField)
        scale = try container.decodeIfPresent(Float.self, forKey: .scale)
        focalLength = try container.decodeIfPresent(Float.self, forKey: .focalLength)
        
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
        try container.encode(shift, forKey: .shift)
        try container.encodeIfPresent(depthOfField, forKey: .depthOfField)
        try container.encodeIfPresent(scale, forKey: .scale)
        try container.encodeIfPresent(focalLength, forKey: .focalLength)
        
        var matrixEntries: [Float] = .init(repeating: 0, count: 16)
        for y in 0..<4 {
            for x in 0..<4 {
                matrixEntries[4 * y + x] = transform[x, y]
            }
        }
        try container.encode(matrixEntries, forKey: .transform)
    }
}
