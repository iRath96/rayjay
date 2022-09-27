import Foundation

public struct TexImageKernel: NodeKernel {
    public static let id = "TEX_IMAGE"

    public var filepath: String
    public var interpolation: String
    public var projection: String
    public var `extension`: String
    public var source: String
    public var colorspace: String
    public var alpha: String
    
    public init(
        filepath: String, interpolation: String,
        projection: String, `extension`: String,
        source: String, colorspace: String, alpha: String
    ) {
        self.filepath = filepath
        self.interpolation = interpolation
        self.projection = projection
        self.`extension` = `extension`
        self.source = source
        self.colorspace = colorspace
        self.alpha = alpha
    }
}
