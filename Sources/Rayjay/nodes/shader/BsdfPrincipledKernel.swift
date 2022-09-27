import Foundation

public struct BsdfPrincipledKernel: NodeKernel {
    public static let id = "BSDF_PRINCIPLED"
    
    public var distribution: String
    public var subsurfaceMethod: String
    
    public init(distribution: String, subsurfaceMethod: String) {
        self.distribution = distribution
        self.subsurfaceMethod = subsurfaceMethod
    }
    
    private enum CodingKeys: String, CodingKey {
        case distribution
        case subsurfaceMethod = "subsurface_method"
    }
}
