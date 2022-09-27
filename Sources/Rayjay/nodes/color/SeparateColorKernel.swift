import Foundation

public struct SeparateColorKernel: NodeKernel {
    public static let id = "COLOR_SEPARATE"
    
    public var mode: String
    
    public init(mode: String) {
        self.mode = mode
    }
}
