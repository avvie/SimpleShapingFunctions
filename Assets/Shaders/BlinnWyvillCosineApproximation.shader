// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "ImageEffects/BlinnWyvillCosineApproximation"
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
                float2 xy = screenSpaceConversion(i.screenPos);

                // xy.x += _Time;
                float y = blinnWyvillCosineApproximation(xy.x);
                float3 color = float3(y, 0, 0);

                float pct = plot(xy, y);

                color = ((1-pct)*color + pct * float3(1,0,0));
                color = pct;
                return float4(color, 1);
            }
            ENDCG
        }
    }
    
}
