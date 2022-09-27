import Foundation

public struct MappingKernel: NodeKernel {
    public static let id = "MAPPING"

    public var type: String
    
    public init(type: String) {
        self.type = type
    }
}
