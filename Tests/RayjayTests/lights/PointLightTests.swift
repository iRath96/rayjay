import XCTest
import Rayjay

final class PointLightTests: XCTestCase {
    var light: Light!
    
    override func setUp() async throws {
        let path = Bundle.module.path(forResource: "PointLight", ofType: "json")!
        let loader = SceneLoader()
        let scene = try loader.makeScene(fromURL: URL(fileURLWithPath: path))
        light = scene.lights["Point"]!
    }
    
    func testMaterial() throws {
        XCTAssertEqual(light.material, "Point")
    }
    
    func testVisibility() throws {
        XCTAssertEqual(light.visibility, .all.subtracting(.camera))
    }
    
    func testCastShadows() throws {
        XCTAssertEqual(light.castShadows, false)
    }
    
    func testUseMIS() throws {
        XCTAssertEqual(light.useMIS, false)
    }
    
    func testKernel() throws {
        let kernel = light.kernel as? PointLight
        XCTAssertNotNil(kernel)
        
        if let pointLight = kernel {
            XCTAssertEqual(pointLight.color, SIMD3(10, 20, 30))
            XCTAssertEqual(pointLight.location, SIMD3(0, 1, 2))
            XCTAssertEqual(pointLight.power, 10)
            XCTAssertEqual(pointLight.radius, 0.25)
        }
    }
}
