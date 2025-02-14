﻿Shader "Holistic/Challenge1_PBR_Emissive"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MetallicTex ("Metallic (R)", 2D) = "white" {}
        _Metallic ("Metallic", Range(0.0, 1.0)) = 0.0
		_Emission ("Emission", Range(0,1)) = 0
    }
    SubShader
    {
        Tags { "Queue"="Geometry" }

        CGPROGRAM
        
        #pragma surface surf Standard

        sampler2D _MetallicTex;
		half _Metallic;
		fixed4 _Color;
		half _Emission;

        struct Input
        {
            float2 uv_MetallicTex;
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
			o.Albedo = _Color.rgb;
            o.Metallic = _Metallic;
            o.Smoothness = tex2D (_MetallicTex, IN.uv_MetallicTex).r;
            o.Alpha = _Color.a;
			o.Emission = (tex2D(_MetallicTex, IN.uv_MetallicTex).r) * _Emission;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
