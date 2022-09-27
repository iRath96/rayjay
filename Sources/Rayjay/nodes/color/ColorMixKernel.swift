import Foundation

public struct ColorMixKernel: NodeKernel {
    public static let id = "MIX_RGB"

    public var blendType: String
    public var useClamp: Bool
    
    public init(blendType: String, useClamp: Bool) {
        self.blendType = blendType
        self.useClamp = useClamp
    }
    
    private enum CodingKeys: String, CodingKey {
        case blendType = "blend_type"
        case useClamp = "use_clamp"
    }
}
