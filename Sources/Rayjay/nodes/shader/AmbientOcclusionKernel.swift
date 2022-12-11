import Foundation

public struct AmbientOcclusionKernel: NodeKernel {
    public static let id = "AMBIENT_OCCLUSION"
    
    public var inside: Bool
    public var onlyLocal: Bool
    public var samples: Int
    
    public init(inside: Bool, onlyLocal: Bool, samples: Int) {
        self.inside = inside
        self.onlyLocal = onlyLocal
        self.samples = samples
    }
    
    private enum CodingKeys: String, CodingKey {
        case inside
        case onlyLocal = "only_local"
        case samples
    }
}
