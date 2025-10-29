vec3 applyLighting(vec3 color, vec3 lightColor, vec3 normal, vec3 lightDir) {
    float diff = max(dot(normal, lightDir), 0.0);
    return color * (0.5 + 0.5 * diff) * lightColor;
}
