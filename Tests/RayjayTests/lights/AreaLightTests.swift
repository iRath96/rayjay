import XCTest
import Rayjay
import simd

final class AreaLightTests: XCTestCase {
    var light: Light!
    
    override func setUp() async throws {
        let path = Bundle.module.path(forResource: "AreaLight", ofType: "json")!
        let loader = SceneLoader()
        let scene = try loader.makeScene(fromURL: URL(fileURLWithPath: path))
        light = scene.lights["Area"]!
    }
    
    func testMaterial() throws {
        XCTAssertEqual(light.material, "Area")
    }
    
    func testVisibility() throws {
        XCTAssertEqual(light.visibility, .camera)
    }
    
    func testCastShadows() throws {
        XCTAssertEqual(light.castShadows, true)
    }
    
    func testUseMIS() throws {
        XCTAssertEqual(light.useMIS, false)
    }
    
    func testKernel() throws {
        let kernel = light.kernel as? AreaLight
        XCTAssertNotNil(kernel)
        
        if let areaLight = kernel {
            XCTAssertEqual(areaLight.power, 5)
            XCTAssertEqual(areaLight.color, SIMD3(0.25, 0.5, 1))
            XCTAssertEqual(areaLight.isCirular, false)
            XCTAssertEqual(areaLight.spread, 3.5)
            XCTAssertEqual(areaLight.transform, simd_float3x4(
                .init(1, 2, 3, 4),
                .init(1, 3, 3, 7),
                .init(0, 4, 2, 0)
            ))
        }
    }
}
