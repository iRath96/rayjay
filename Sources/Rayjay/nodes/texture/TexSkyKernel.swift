import Foundation

public struct TexSkyKernel: NodeKernel {
    public static let id = "TEX_SKY"

    public var type: String
    public var airDensity: Float
    public var altitude: Float
    public var dustDensity: Float
    public var groundAlbedo: Float
    public var ozoneDensity: Float
    public var sunDirection: [Float]
    public var sunDisc: Bool
    
    /// in radians [0;pi/2)
    public var sunElevation: Float
    public var sunIntensity: Float
    
    /// in radians [0;2pi)
    public var sunRotation: Float
    public var sunSize: Float
    public var turbidity: Float
    
    public init(
        type: String, airDensity: Float, altitude: Float, dustDensity: Float,
        groundAlbedo: Float, ozoneDensity: Float,
        sunDirection: [Float], sunDisc: Bool, sunElevation: Float, sunIntensity: Float,
        sunRotation: Float, sunSize: Float, turbidity: Float
    ) {
        self.type = type
        self.airDensity = airDensity
        self.altitude = altitude
        self.dustDensity = dustDensity
        self.groundAlbedo = groundAlbedo
        self.ozoneDensity = ozoneDensity
        self.sunDirection = sunDirection
        self.sunDisc = sunDisc
        self.sunElevation = sunElevation
        self.sunIntensity = sunIntensity
        self.sunRotation = sunRotation
        self.sunSize = sunSize
        self.turbidity = turbidity
    }
    
    private enum CodingKeys: String, CodingKey {
        case type = "sky_type"
        case airDensity = "air_density"
        case altitude
        case dustDensity = "dust_density"
        case groundAlbedo = "ground_albedo"
        case ozoneDensity = "ozone_density"
        case sunDirection = "sun_direction"
        case sunDisc = "sun_disc"
        case sunElevation = "sun_elevation"
        case sunIntensity = "sun_intensity"
        case sunRotation = "sun_rotation"
        case sunSize = "sun_size"
        case turbidity
    }
}
