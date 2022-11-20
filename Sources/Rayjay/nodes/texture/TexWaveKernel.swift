import Foundation

public struct TexWaveKernel: NodeKernel {
    public static let id = "TEX_WAVE"
    
    public var type: String
    public var profile: String
    public var direction: String
    
    public init(type: String, profile: String, direction: String) {
        self.type = type
        self.profile = profile
        self.direction = direction
    }
}
