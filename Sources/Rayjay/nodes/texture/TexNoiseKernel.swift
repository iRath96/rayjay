import Foundation

public struct TexNoiseKernel: NodeKernel {
    public static let id = "TEX_NOISE"

    public var dimension: String
    
    public init(dimension: String) {
        self.dimension = dimension
    }
    
    private enum CodingKeys: String, CodingKey {
        case dimension = "noise_dimensions"
    }
}
