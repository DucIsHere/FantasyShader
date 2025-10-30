#include "/include/aurora_overworld.glsl"
#include "/include/aurora_the_end.glsl"

uniform float biomeCategory;
uniform vec4 biome;
uniform float temperature;
uniform float rainStrength;



vec3 auroraColor = vec3(0.0);
#if defined(OVERWORLD)
    auroraColor = drawAuroraOverworld(uv, time);
#elif defined(THE_END)
    auroraColor = drawAuroraEnd(uv, time);
#ifdef OVERWORLD
    float auroraStrength = smoothstep(0.4, 0.2, temperature);
    auroraColor *= auroraStrength;
    float auroraStrength = 0.0;
    // dùng uniform temperature (Iris có sẵn)
    auroraStrength = smoothstep(0.4, 0.2, temperature);

    if (rainStrength < 0.1) {
        vec3 auroraColor = drawAuroraOverworld(uv, time);
        finalColor += auroraColor * auroraStrength;
    }

#endif

finalColor += auroraColor;
