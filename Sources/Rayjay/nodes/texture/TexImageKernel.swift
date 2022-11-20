import Foundation

public struct TexImageKernel: NodeKernel {
    public static let id = "TEX_IMAGE"

    public var filepath: URL
    public var interpolation: String
    public var projection: String
    public var `extension`: String
    public var source: String
    public var colorspace: String
    public var alpha: String
    
    public init(
        filepath: URL, interpolation: String,
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
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let path = try container.decode(String.self, forKey: .filepath)
        self.filepath = try decoder.configuration.resolve(path: path)
        self.interpolation = try container.decode(String.self, forKey: .interpolation)
        self.projection = try container.decode(String.self, forKey: .projection)
        self.extension = try container.decode(String.self, forKey: .extension)
        self.source = try container.decode(String.self, forKey: .source)
        self.colorspace = try container.decode(String.self, forKey: .colorspace)
        self.alpha = try container.decode(String.self, forKey: .alpha)
    }
}
