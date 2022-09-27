import Foundation

public struct CombineColorKernel: NodeKernel {
    public static let id = "COMBINE_COLOR"
    
    public var mode: String
    
    public init(mode: String) {
        self.mode = mode
    }
}
