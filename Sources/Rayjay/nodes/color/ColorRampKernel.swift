import Foundation

public struct ColorRampKernel: NodeKernel {
    public static let id = "VALTORGB"

    public struct Element: Codable, Equatable {
        var position: Float
        var color: [Float]
        
        public init(position: Float, color: [Float]) {
            self.position = position
            self.color = color
        }
    }

    public var colorMode: String
    public var interpolation: String
    public var hueInterpolation: String
    public var elements: [Element]
    
    public init(colorMode: String, interpolation: String, hueInterpolation: String, elements: [ColorRampKernel.Element]) {
        self.colorMode = colorMode
        self.interpolation = interpolation
        self.hueInterpolation = hueInterpolation
        self.elements = elements
    }
    
    private enum CodingKeys: String, CodingKey {
        case colorMode = "color_mode"
        case interpolation
        case hueInterpolation = "hue_interpolation"
        case elements
    }
}
