import Foundation

public struct BsdfHairKernel: NodeKernel {
    public static let id = "BSDF_HAIR"
    
    public var component: String
    
    public init(component: String) {
        self.component = component
    }
}
