import Foundation

public struct DisplacementKernel: NodeKernel {
    public static let id = "DISPLACEMENT"

    public var space: String
    
    public init(space: String) {
        self.space = space
    }
}
