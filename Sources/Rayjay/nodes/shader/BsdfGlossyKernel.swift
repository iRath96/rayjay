import Foundation

public struct BsdfGlossyKernel: NodeKernel {
    public static let id = "BSDF_GLOSSY"
    
    public var distribution: String
    
    public init(distribution: String) {
        self.distribution = distribution
    }
}
