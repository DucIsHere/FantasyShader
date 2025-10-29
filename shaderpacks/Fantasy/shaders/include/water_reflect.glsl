vec3 waterReflection(vec3 viewDir, vec3 normal, vec3 skyColor) {
    float fresnel = pow(1.0 - max(dot(viewDir, normal), 0.0), 3.0);
    return skyColor * fresnel * water_reflect_strength;
}
