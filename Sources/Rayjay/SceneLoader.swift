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
        TexVoronoiKernel.self,
        TexMusgraveKernel.self,
        TexGradientKernel.self,
        TexBrickKernel.self,
        TexWaveKernel.self,
        
        // shader nodes
        BsdfPrincipledKernel.self,
        BsdfDiffuseKernel.self,
        BsdfGlassKernel.self,
        BsdfGlossyKernel.self,
        BsdfTransparentKernel.self,
        BsdfTranslucentKernel.self,
        BsdfRefractionKernel.self,
        BsdfAnisotropicKernel.self,
        BsdfVelvetKernel.self,
        BsdfHairKernel.self,
        EmissionKernel.self,
        AddShaderKernel.self,
        MixShaderKernel.self,
        FresnelKernel.self,
        LayerWeightKernel.self,
        BackgroundKernel.self,
        LightFalloffKernel.self,
        VolumeScatterKernel.self,
        AmbientOcclusionKernel.self,
        
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
        RGBKernel.self,
        RGBToBWKernel.self,
        
        // math nodes
        MappingKernel.self,
        NormalMappingKernel.self,
        BumpMappingKernel.self,
        DisplacementKernel.self,
        CombineVectorKernel.self,
        SeparateVectorKernel.self,
        VectorMathKernel.self,
        MathKernel.self,
        MixKernel.self,
        MapRangeKernel.self,
        
        // input nodes
        AttributeKernel.self,
        ValueKernel.self,
        LightPathKernel.self,
        NewGeometryKernel.self,
        TexCoordKernel.self,
        UVMapKernel.self,
        ObjectInfoKernel.self,
        ParticleInfoKernel.self,
        VertexColorKernel.self,
        NormalKernel.self,
        
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
            baseURL: url,
            nodeKernels: nodeKernels,
            lightKernels: lightKernels
        )
        
        return try decoder.decode(Scene.self, from: data)
    }
    
    public func makeScene(fromURL url: URL) throws -> Scene {
        let data = try Data(contentsOf: url)
        return try makeScene(fromData: data, baseURL: url)
    }
}
