import Foundation

public struct ValueKernel: NodeKernel {
    public static let id = "VALUE"

    public var value: Float
    
    public init(value: Float) {
        self.value = value
    }
}
