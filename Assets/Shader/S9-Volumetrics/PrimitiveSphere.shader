﻿Shader "Holistic/9/PrimitiveSphere"
{
    SubShader
    {
        Tags { "Queue"="Transparent" }
        Blend SrcAlpha OneMinusSrcAlpha

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float3 wPos : TEXCOORD0;
                float4 pos : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.wPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                return o;
            }

            #define STEPS 64
            #define STEP_SIZE 0.01

            bool sphereHit(float3 pos, float3 center, float radius) {
                return distance(pos, center) < radius;
            }

            float raymarchHit(float3 position, float3 direction) 
            {
                for(int i = 0; i < STEPS; i++) {
                    
                    if (sphereHit(position, float3(0,0,0), 0.5)){
                        return position;
                    }

                    position += direction * STEP_SIZE;
                }
                return 0;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float3 viewDir = normalize(i.wPos - _WorldSpaceCameraPos);
                float depth = raymarchHit(i.wPos, viewDir);

                if (depth != 0) {
                    return fixed4(1, 0, 0, 1);
                } else {
                    return fixed4(0, 0, 0, 0);
                }
            }
            ENDCG
        }
    }
}
