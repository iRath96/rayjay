import Foundation

public struct SunLight: LightKernel {
    public static var id = "SUN"
    
    public var direction: SIMD3<Float>
    public var power: Float
    public var color: SIMD3<Float>
    public var angle: Float
    
    public init(direction: SIMD3<Float>, power: Float, color: SIMD3<Float>, angle: Float) {
        self.direction = direction
        self.power = power
        self.color = color
        self.angle = angle
    }
}
