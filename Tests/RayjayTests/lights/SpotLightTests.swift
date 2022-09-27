import XCTest
import Rayjay
import simd

final class SpotLightTests: XCTestCase {
    var light: Light!
    
    override func setUp() async throws {
        let path = Bundle.module.path(forResource: "SpotLight", ofType: "json")!
        let loader = SceneLoader()
        let scene = try loader.makeScene(fromURL: URL(fileURLWithPath: path))
        light = scene.lights["Spot"]!
    }
    
    func testMaterial() throws {
        XCTAssertEqual(light.material, "Spot")
    }
    
    func testVisibility() throws {
        XCTAssertEqual(light.visibility, [.diffuse, .glossy, .shadow])
    }
    
    func testCastShadows() throws {
        XCTAssertEqual(light.castShadows, false)
    }
    
    func testUseMIS() throws {
        XCTAssertEqual(light.useMIS, true)
    }
    
    func testKernel() throws {
        let kernel = light.kernel as? SpotLight
        XCTAssertNotNil(kernel)
        
        if let spotLight = kernel {
            XCTAssertEqual(spotLight.color, SIMD3(-1, -2, 1))
            XCTAssertEqual(spotLight.power, 100)
            XCTAssertEqual(spotLight.radius, 0.125)
            XCTAssertEqual(spotLight.location, SIMD3(-1, 10, 3))
            XCTAssertEqual(spotLight.direction, SIMD3(0, 1, 0))
            XCTAssertEqual(spotLight.spotBlend, 0.5)
            XCTAssertEqual(spotLight.spotSize, 0.75)
        }
    }
}
