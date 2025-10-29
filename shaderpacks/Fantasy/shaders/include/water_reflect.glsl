#include "/include/options.glsl"
#include "/include/noise.glsl"

// Dynamic wave distortion (for Unbound mode)
vec3 waterDistort(vec2 uv, float time) {
    float n = fbm(uv * 5.0 + time * 0.1);
    vec2 offset = vec2(n * 0.02, n * 0.015);
    return vec3(offset, n);
}

vec3 waterReflection(vec3 viewDir, vec3 normal, vec3 skyColor, vec2 uv, float time) {
    if (water_mode == 0) {
        // --- Vanilla Mode ---
        float fresnel = pow(1.0 - max(dot(viewDir, normal), 0.0), 3.0);
        return skyColor * fresnel * 0.3;
    } else {
        // --- Unbound (Realistic Remagined) Mode ---
        vec3 distortion = waterDistort(uv, time);
        vec3 reflectDir = reflect(-viewDir, normal + distortion * 0.1);
        float fresnel = pow(1.0 - max(dot(viewDir, normal), 0.0), 5.0);
        vec3 color = skyColor * (0.8 + 0.2 * distortion.z);
        return mix(color, skyColor, fresnel) * 1.2;
    }
}
