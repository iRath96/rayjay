import XCTest
import Rayjay
import simd

final class SunLightTests: XCTestCase {
    var light: Light!
    
    override func setUp() async throws {
        let path = Bundle.module.path(forResource: "SunLight", ofType: "json")!
        let loader = SceneLoader()
        let scene = try loader.makeScene(fromURL: URL(fileURLWithPath: path))
        light = scene.lights["Sun"]!
    }
    
    func testMaterial() throws {
        XCTAssertEqual(light.material, "Sun")
    }
    
    func testVisibility() throws {
        XCTAssertEqual(light.visibility, .all)
    }
    
    func testCastShadows() throws {
        XCTAssertEqual(light.castShadows, true)
    }
    
    func testUseMIS() throws {
        XCTAssertEqual(light.useMIS, true)
    }
    
    func testKernel() throws {
        let kernel = light.kernel as? SunLight
        XCTAssertNotNil(kernel)
        
        if let sunLight = kernel {
            XCTAssertEqual(sunLight.direction, SIMD3(0, 0, -1))
            XCTAssertEqual(sunLight.power, 1)
            XCTAssertEqual(sunLight.color, SIMD3(1, 1, 1))
            XCTAssertEqual(sunLight.angle, 0.125)
        }
    }
}
