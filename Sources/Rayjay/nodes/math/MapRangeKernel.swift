import Foundation

public struct MapRangeKernel: NodeKernel {
    public static let id = "MAP_RANGE"

    public var clamp: Bool
    public var dataType: String
    public var interpolationType: String
    
    public init(clamp: Bool, dataType: String, interpolationType: String) {
        self.clamp = clamp
        self.dataType = dataType
        self.interpolationType = interpolationType
    }
    
    private enum CodingKeys: String, CodingKey {
        case clamp
        case dataType = "data_type"
        case interpolationType = "interpolation_type"
    }
}
