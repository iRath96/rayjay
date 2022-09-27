import XCTest
import Rayjay
import simd

final class SimpleNodeTests: XCTestCase {
    var scene: Scene!
    var world: Material!
    var mat1: Material!
    var mat2: Material!
    
    override func setUp() async throws {
        let path = Bundle.module.path(forResource: "SimpleNodes", ofType: "json")!
        let loader = SceneLoader()
        
        scene = try loader.makeScene(fromURL: URL(fileURLWithPath: path))
        world = scene.materials["World"]!
        mat1 = scene.materials["Material"]!
        mat2 = scene.materials["Material.001"]!
    }
    
    func testWorldOutput() throws {
        let outputNode = world.nodes["World Output"]!
        let outputKernel = outputNode.kernel as! OutputWorldKernel
        XCTAssertEqual(outputNode.inputs, [
            "Volume": .shader(),
            "Surface": .shader("Background", "Background")
        ])
        XCTAssertEqual(outputKernel, OutputWorldKernel())
    }
    
    func testNoiseNode() throws {
        let noiseNode = mat1.nodes["Noise Texture"]!
        let noiseKernel = noiseNode.kernel as! TexNoiseKernel
        XCTAssertEqual(noiseNode.inputs, [
            "Vector": .vector([0, 0, 0]),
            "W": .scalar(0),
            "Scale": .scalar(5),
            "Detail": .scalar(2),
            "Roughness": .scalar(0.5),
            "Distortion": .scalar(0)
        ])
        XCTAssertEqual(noiseKernel, TexNoiseKernel(dimension: "3D"))
    }
    
    func testEncoding() throws {
        let encoder = JSONEncoder()
        let encoded = try encoder.encode(scene)
        
        let loader = SceneLoader()
        let decoded = try loader.makeScene(fromData: encoded)
        
        XCTAssertEqual(scene, decoded)
    }
}
