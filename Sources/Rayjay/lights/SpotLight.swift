import Foundation

public struct SpotLight: LightKernel {
    public static var id = "SPOT"
    
    public var location: SIMD3<Float>
    public var direction: SIMD3<Float>
    public var power: Float
    public var color: SIMD3<Float>
    public var radius: Float
    
    public var spotSize: Float
    public var spotBlend: Float
    
    public init(
        location: SIMD3<Float>, direction: SIMD3<Float>,
        power: Float, color: SIMD3<Float>, radius: Float,
        spotSize: Float, spotBlend: Float
    ) {
        self.location = location
        self.direction = direction
        self.power = power
        self.color = color
        self.radius = radius
        self.spotSize = spotSize
        self.spotBlend = spotBlend
    }
    
    private enum CodingKeys: String, CodingKey {
        case location, direction, power, color, radius
        case spotSize = "spot_size"
        case spotBlend = "spot_blend"
    }
}
