import Foundation
import simd

extension simd_float3x4: Codable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        for col in [ self.columns.0, self.columns.1, self.columns.2 ] {
            for i in 0..<4 {
                try container.encode(col[i])
            }
        }
    }
    
    public init(from decoder: Decoder) throws {
        self.init()
        
        var container = try decoder.unkeyedContainer()
        func readSIMD4() throws -> SIMD4<Float> {
            var col = SIMD4<Float>()
            for i in 0..<4 {
                col[i] = try container.decode(Float.self)
            }
            return col
        }
        
        columns.0 = try readSIMD4()
        columns.1 = try readSIMD4()
        columns.2 = try readSIMD4()
    }
}
