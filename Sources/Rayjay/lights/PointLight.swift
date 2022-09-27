import Foundation

public struct PointLight: LightKernel {
    public static var id = "POINT"
    
    public var location: SIMD3<Float>
    public var power: Float
    public var color: SIMD3<Float>
    public var radius: Float
    
    public init(location: SIMD3<Float>, power: Float, color: SIMD3<Float>, radius: Float) {
        self.location = location
        self.power = power
        self.color = color
        self.radius = radius
    }
}
