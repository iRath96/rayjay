import Foundation

public struct SceneLoader {
    public var nodeKernels: [any NodeKernel.Type] = [
        // texture nodes
        TexImageKernel.self,
        TexEnvironmentKernel.self,
        TexCheckerKernel.self,
        TexNoiseKernel.self,
        TexSkyKernel.self,
        TexIESKernel.self,
        TexMagicKernel.self,
        
        // shader nodes
        BsdfPrincipledKernel.self,
        BsdfDiffuseKernel.self,
        BsdfGlassKernel.self,
        BsdfGlossyKernel.self,
        BsdfTransparentKernel.self,
        BsdfTranslucentKernel.self,
        BsdfRefractionKernel.self,
        BsdfAnisotropicKernel.self,
        EmissionKernel.self,
        AddShaderKernel.self,
        MixShaderKernel.self,
        FresnelKernel.self,
        LayerWeightKernel.self,
        BackgroundKernel.self,
        
        // color nodes
        ColorRampKernel.self,
        ColorMixKernel.self,
        ColorCurvesKernel.self,
        ColorInvertKernel.self,
        CombineColorKernel.self,
        SeparateColorKernel.self,
        HueSaturationKernel.self,
        BlackbodyKernel.self,
        BrightnessContrastKernel.self,
        GammaKernel.self,
        
        // vector nodes
        MappingKernel.self,
        NormalMappingKernel.self,
        BumpMappingKernel.self,
        DisplacementKernel.self,
        CombineVectorKernel.self,
        SeparateVectorKernel.self,
        VectorMathKernel.self,
        MathKernel.self,
        
        // input nodes
        AttributeKernel.self,
        ValueKernel.self,
        LightPathKernel.self,
        NewGeometryKernel.self,
        TexCoordKernel.self,
        UVMapKernel.self,
        
        // output nodes
        OutputMaterialKernel.self,
        OutputWorldKernel.self,
        OutputLightKernel.self,
    ]
    
    public var lightKernels: [any LightKernel.Type] = [
        AreaLight.self,
        PointLight.self,
        SpotLight.self,
        SunLight.self,
        WorldLight.self
    ]
    
    public init() {
    }
    
    public func makeScene(fromData data: Data, baseURL url: URL? = nil) throws -> Scene {
        let decoder = JSONDecoder()
        decoder.userInfo[.init(rawValue: "configuration")!] = Scene.DecodingConfiguration(
            nodeKernels: nodeKernels,
            lightKernels: lightKernels
        )
        
        var scene = try decoder.decode(Scene.self, from: data)
        if let url = url {
            for (shapeName, shape) in scene.shapes {
                /// make all relative paths of shapes absolute
                let filepath = URL(string: shape.filepath.relativePath, relativeTo: url)!.absoluteURL
                scene.shapes[shapeName]!.filepath = filepath
            }
        }
        return scene
    }
    
    public func makeScene(fromURL url: URL) throws -> Scene {
        let data = try Data(contentsOf: url)
        return try makeScene(fromData: data, baseURL: url)
    }
}
