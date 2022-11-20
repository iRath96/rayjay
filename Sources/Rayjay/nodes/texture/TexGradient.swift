import Foundation

public struct TexGradientKernel: NodeKernel {
    public static let id = "TEX_GRADIENT"
    
    public var type: String
    
    public init(type: String) {
        self.type = type
    }
}
