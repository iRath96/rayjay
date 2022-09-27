import Foundation

public struct NormalMappingKernel: NodeKernel {
    public static let id = "NORMAL_MAP"

    public var space: String
    public var uvMap: String
    
    public init(space: String, uvMap: String) {
        self.space = space
        self.uvMap = uvMap
    }
    
    private enum CodingKeys: String, CodingKey {
        case space
        case uvMap = "uv_map"
    }
}
