import Foundation

public struct BsdfGlassKernel: NodeKernel {
    public static let id = "BSDF_GLASS"
    
    public var distribution: String
    
    public init(distribution: String) {
        self.distribution = distribution
    }
}
