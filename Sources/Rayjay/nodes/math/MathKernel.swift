import Foundation

public struct MathKernel: NodeKernel {
    public static let id = "MATH"

    public var operation: String
    public var useClamp: Bool
    
    public init(operation: String, useClamp: Bool) {
        self.operation = operation
        self.useClamp = useClamp
    }
    
    private enum CodingKeys: String, CodingKey {
        case operation
        case useClamp = "use_clamp"
    }
}
