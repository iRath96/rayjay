import Foundation

public struct TexEnvironmentKernel: NodeKernel {
    public static let id = "TEX_ENVIRONMENT"

    public var filepath: String
    public var interpolation: String
    public var projection: String
    public var colorspace: String
    public var alpha: String
    
    public init(filepath: String, interpolation: String, projection: String, colorspace: String, alpha: String) {
        self.filepath = filepath
        self.interpolation = interpolation
        self.projection = projection
        self.colorspace = colorspace
        self.alpha = alpha
    }
}
