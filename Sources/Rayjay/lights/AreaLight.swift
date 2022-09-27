import Foundation
import simd

public struct AreaLight: LightKernel {
    public static var id = "AREA"
    
    public var transform: simd_float3x4
    public var power: Float
    public var color: SIMD3<Float>
    public var spread: Float
    public var isCirular: Bool
    
    private enum CodingKeys: String, CodingKey {
        case transform, power, color, spread
        case isCirular = "is_circular"
    }
    
    public init(transform: simd_float3x4, power: Float, color: SIMD3<Float>, spread: Float, isCirular: Bool) {
        self.transform = transform
        self.power = power
        self.color = color
        self.spread = spread
        self.isCirular = isCirular
    }
}
