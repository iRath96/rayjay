import Foundation

public struct MixKernel: NodeKernel {
    public static let id = "MIX"

    public var type: String
    public var clampResult: Bool
    public var clampFactor: Bool
    public var factorMode: String
    
    public init(type: String, clampResult: Bool, clampFactor: Bool, factorMode: String) {
        self.type = type
        self.clampResult = clampResult
        self.clampFactor = clampFactor
        self.factorMode = factorMode
    }
    
    private enum CodingKeys: String, CodingKey {
        case type
        case clampResult = "clamp_result"
        case clampFactor = "clamp_factor"
        case factorMode = "factor_mode"
    }
}
