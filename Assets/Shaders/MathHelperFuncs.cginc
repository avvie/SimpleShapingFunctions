// Upgrade NOTE: replaced 'defined IMAGE_EFFECT_VERTEX' with 'defined (IMAGE_EFFECT_VERTEX)'

#if !defined (MATH_HELPER_FUNCS)
    #define MATH_HELPER_FUNCS

    float plot(float2 xy, float y){
        return smoothstep( y-0.02, y, xy.y) - smoothstep( y, y+0.02, xy.y);
    }

    float applySineTransform(float2 xy, float frequency, float  phase, float amplitudeCoeff, float offset, half t){
        return offset + amplitudeCoeff * sin(frequency * (xy+ t * _Time) + phase);
    }

    float applyCosineTransform(float2 xy, float frequency, float  phase, float amplitudeCoeff, float offset, half t){
        return offset + amplitudeCoeff * cos(frequency * (xy+ t * _Time) + phase);
    }

    float blinnWyvillCosineApproximation(float x){
        float xx = x * x;
        float x2 = xx * xx;
        float x6 = x2 * xx;

        return (4.0/9.0) * x6 + (17.0/9.0) * x2 + (22.0/9.0) * xx;
    }

#endif