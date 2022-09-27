import Foundation

public struct UVMapKernel: NodeKernel {
    public static let id = "UVMAP"

    public var fromInstancer: Bool
    public var uvMap: String
    
    public init(fromInstancer: Bool, uvMap: String) {
        self.fromInstancer = fromInstancer
        self.uvMap = uvMap
    }
    
    private enum CodingKeys: String, CodingKey {
        case fromInstancer = "from_instancer"
        case uvMap = "uv_map"
    }
}
