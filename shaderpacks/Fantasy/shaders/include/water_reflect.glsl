#include "/include/options.glsl"
#include "/include/noise.glsl"

vec3 waterDistort(vec2 uv, float time) {
    // Wave noise animation
    float n = fbm(uv * 5.0 + time * water_reflect_speed);
    vec2 offset = vec2(n * 0.02, n * 0.015) * water_wave_strength;
    return vec3(offset, n);
}

vec3 waterReflection(vec3 viewDir, vec3 normal, vec3 skyColor, vec2 uv, float time) {
    if (water_mode == 0) {
        // --- Vanilla mode ---
        float fresnel = pow(1.0 - max(dot(viewDir, normal), 0.0), 3.0);
        return skyColor * fresnel * 0.3;
    } else {
        // --- Unbound / Realistic Remagined ---
        vec3 distortion = waterDistort(uv, time);
        vec3 reflectDir = reflect(-viewDir, normal + distortion * 0.1);
        float fresnel = pow(1.0 - max(dot(viewDir, normal), 0.0), 5.0);

        // Move reflection by shifting UV + time
        vec2 moveUV = uv + distortion.xy + time * 0.02;
        vec3 moveSky = skyColor * (0.8 + 0.2 * sin(moveUV.x + moveUV.y));

        vec3 color = mix(moveSky, skyColor, fresnel);
        return color * (1.0 + 0.2 * distortion.z);
    }
}
