import Foundation

public struct ColorCurvesKernel: NodeKernel {
    public static let id = "CURVE_RGB"

    public struct CurvePoint: Codable, Equatable {
        public var type: String
        public var location: [Float]
        
        public init(type: String, location: [Float]) {
            self.type = type
            self.location = location
        }
        
        private enum CodingKeys: String, CodingKey {
            case type = "handle_type"
            case location
        }
    }
    
    public var blackLevel: [Float]
    public var whiteLevel: [Float]
    public var clipMinX: Float
    public var clipMinY: Float
    public var clipMaxX: Float
    public var clipMaxY: Float
    public var extend: String
    public var tone: String
    public var curves: [[CurvePoint]]
    
    public init(
        blackLevel: [Float], whiteLevel: [Float],
        clipMinX: Float, clipMinY: Float, clipMaxX: Float, clipMaxY: Float,
        extend: String, tone: String, curves: [[ColorCurvesKernel.CurvePoint]]
    ) {
        self.blackLevel = blackLevel
        self.whiteLevel = whiteLevel
        self.clipMinX = clipMinX
        self.clipMinY = clipMinY
        self.clipMaxX = clipMaxX
        self.clipMaxY = clipMaxY
        self.extend = extend
        self.tone = tone
        self.curves = curves
    }
    
    private enum CodingKeys: String, CodingKey {
        case blackLevel = "black_level"
        case whiteLevel = "white_level"
        case clipMinX = "clip_min_x"
        case clipMinY = "clip_min_y"
        case clipMaxX = "clip_max_x"
        case clipMaxY = "clip_max_y"
        case extend
        case tone
        case curves
    }
}
