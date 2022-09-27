import XCTest
import Rayjay

final class WorldLightTests: XCTestCase {
    var light: Light!
    
    override func setUp() async throws {
        let path = Bundle.module.path(forResource: "WorldLight", ofType: "json")!
        let loader = SceneLoader()
        let scene = try loader.makeScene(fromURL: URL(fileURLWithPath: path))
        light = scene.lights["World"]!
    }
    
    func testMaterial() throws {
        XCTAssertEqual(light.material, "World")
    }
    
    func testVisibility() throws {
        XCTAssertEqual(light.visibility, .all.subtracting(.camera))
    }
    
    func testCastShadows() throws {
        XCTAssertEqual(light.castShadows, true)
    }
    
    func testUseMIS() throws {
        XCTAssertEqual(light.useMIS, true)
    }
    
    func testKernel() throws {
        XCTAssertNotNil(light.kernel as? WorldLight)
        XCTAssertEqual(light.kernel as? WorldLight, WorldLight())
    }
}
