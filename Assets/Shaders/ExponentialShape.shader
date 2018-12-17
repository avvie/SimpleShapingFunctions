// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "ImageEffects/ExponentialShape"
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

            float plot(float2 xy, float y){
                return smoothstep( y-0.02, y, xy.y) - smoothstep( y, y+0.02, xy.y);
            }

            float applyExponentialTransform(float2 xy, float power){
                return pow(xy.x, power);
            }

            float4 FragmentProgram(Interpolators i) : SV_Target{
                float y = applyExponentialTransform(i.screenPos, 2);

                float3 color = y;

                float pct = plot(i.screenPos, y);

                color = (1-pct)*color + pct * float3(0,1,0);
                // color = pct;
                return float4(color, 1);
            }
            ENDCG
        }
    }
    
}
