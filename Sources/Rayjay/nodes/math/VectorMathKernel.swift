import Foundation

public struct VectorMathKernel: NodeKernel {
    public static let id = "VECT_MATH"

    public var operation: String
    
    public init(operation: String) {
        self.operation = operation
    }
}
