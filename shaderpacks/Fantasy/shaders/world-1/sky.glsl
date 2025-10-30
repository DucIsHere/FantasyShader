#include "/include/aurora_the_end.glsl"

#elif defined(THE_END)
    auroraColor = drawAuroraEnd(uv, time);

#endif

finalColor += auroraColor
