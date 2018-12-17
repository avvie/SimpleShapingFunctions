// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "ShapingFunc/ShapingFunction"
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

            float4 FragmentProgram(Interpolators i) : SV_Target{
                float z = _Time.y, l;
                float3 c;
                float2 uv, p, p1 = (i.screenPos.xy / i.screenPos.w);
                // return float4((i.screenPos.xy / i.screenPos.w), 0,1);
                p = p1;
                uv = p1;
                p -= 0.5;
                p.x *= _ScreenParams.x / _ScreenParams.y;
                l = length(p);
                // return float4(float3(abs(p/l), 0), z);

                //Red
                z += 0.07;
                uv += (p / l) * (sin(z) + 1) * abs(sin(l * 9 - z * 2));
                c.x = 0.05/length(abs(glslmod(uv, 1) - 0.5 ));
                
                //Green
                uv = p1;
                z += .07;
                uv += (p / l) * (sin(z) + 1) * abs(sin(l * 9 - z * 2));
                c.y = 0.05/length(abs(glslmod(uv, 1) - 0.5 ));
                
                //Blue
                uv = p1;
                z += 0.07;
                uv += (p / l) * (sin(z) + 1) * abs(sin(l * 9 - z * 2));
                c.z = 0.05/length(abs(glslmod(uv, 1) - 0.5 ));

                //putting it all together
                float4 color = float4(c,1);
                return color;
            }
            ENDCG
        }
    }
    
}
