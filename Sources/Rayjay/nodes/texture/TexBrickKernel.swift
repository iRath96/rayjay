import Foundation

public struct TexBrickKernel: NodeKernel {
    public static let id = "TEX_BRICK"
    
    public var offset: Float
    public var offsetFrequency: Int
    public var squash: Float
    public var squashFrequency: Int
    
    public init(offset: Float, offsetFrequency: Int, squash: Float, squashFrequency: Int) {
        self.offset = offset
        self.offsetFrequency = offsetFrequency
        self.squash = squash
        self.squashFrequency = squashFrequency
    }
    
    private enum CodingKeys: String, CodingKey {
        case offset, squash
        case offsetFrequency = "offset_frequency"
        case squashFrequency = "squash_frequency"
    }
}
