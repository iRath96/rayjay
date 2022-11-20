import Foundation

public struct TexEnvironmentKernel: NodeKernel {
    public static let id = "TEX_ENVIRONMENT"

    public var filepath: URL
    public var interpolation: String
    public var projection: String
    public var colorspace: String
    public var alpha: String
    
    public init(filepath: URL, interpolation: String, projection: String, colorspace: String, alpha: String) {
        self.filepath = filepath
        self.interpolation = interpolation
        self.projection = projection
        self.colorspace = colorspace
        self.alpha = alpha
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let path = try container.decode(String.self, forKey: .filepath)
        self.filepath = try decoder.configuration.resolve(path: path)
        self.interpolation = try container.decode(String.self, forKey: .interpolation)
        self.projection = try container.decode(String.self, forKey: .projection)
        self.colorspace = try container.decode(String.self, forKey: .colorspace)
        self.alpha = try container.decode(String.self, forKey: .alpha)
    }
}
