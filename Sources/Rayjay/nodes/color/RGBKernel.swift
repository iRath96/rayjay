import Foundation

public struct RGBKernel: NodeKernel {
    public static let id = "RGB"
    
    public var value: SIMD4<Float>
    
    public init(value: SIMD4<Float>) {
        self.value = value
    }
}
