import Foundation

public struct SeparateColorKernel: NodeKernel {
    public static let id = "SEPARATE_COLOR"
    
    public var mode: String
    
    public init(mode: String) {
        self.mode = mode
    }
}
