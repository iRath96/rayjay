import Foundation

public struct RenderSettings: Codable, Equatable {
    public struct Resolution: Codable, Equatable {
        var width: Float
        var height: Float
        
        public init(width: Float, height: Float) {
            self.width = width
            self.height = height
        }
    }
    
    public var resolution: Resolution
    
    public init(resolution: RenderSettings.Resolution) {
        self.resolution = resolution
    }
}
