import Foundation

public struct BumpMappingKernel: NodeKernel {
    public static let id = "BUMP"

    public var invert: Bool
    
    public init(invert: Bool) {
        self.invert = invert
    }
}
