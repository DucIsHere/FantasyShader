#include "/include/aurora_overworld.glsl"
#include "/include/aurora_the_end.glsl"

vec3 auroraColor = vec3(0.0);
#if defined(OVERWORLD)
    auroraColor = drawAuroraOverworld(uv, time);
#elif defined(THE_END)
    auroraColor = drawAuroraEnd(uv, time);
#endif

finalColor += auroraColor;
