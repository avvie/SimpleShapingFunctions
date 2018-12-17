// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "ImageEffects/SineCosineShape"
{
    Properties
    {
        
    }
    SubShader
    {
        Pass{
            Cull off
            ZTest Always
            ZWrite Off

            CGPROGRAM
            
            #include "UnityCG.cginc"
            // Use shader model 3.0 target, to get nicer looking lighting
            #pragma target 3.0

            #pragma vertex VertexProgram
            #pragma fragment FragmentProgram
            
            #include "ImageEffectVertex.cginc"
            #include "MathHelperFuncs.cginc"
            

            float4 FragmentProgram(Interpolators i) : SV_Target{
                float2 xy = screenSpaceConversionCentered(i.screenPos);

                // xy.x += _Time;
                float x = applySineTransform(xy, 8, 0, 0.5, 0, 1);
                float y = applyCosineTransform(xy, 8, 0, 0.5, 0, 1);
                float z = applyCosineTransform(xy, 8, 0, 0.5, 0, 1) * applySineTransform(xy, 8, 0, 0.5, 0, 1);
                float3 color = float3(x, y, 0);

                float pct = plot(xy, x);
                float pct1 = plot(xy, y);
                float pct2 = plot(xy, z);

                color = ((1-pct)*color + pct * float3(1,0,0)) + ((1-pct1)*color + pct1 * float3(0,1,0)) + ((1-pct2)*color + pct2 * float3(0,0,1));
                // color = pct + pct1;
                return float4(normalize(color), 1);
            }
            ENDCG
        }
    }
    
}
