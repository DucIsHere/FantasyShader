float getCloudShadow(vec3 worldPos, float time) {
    float n = fbm(worldPos.xz * 0.0004 + time * 0.02);
    return 1.0 - smoothstep(0.45, 0.6, n) * 0.4;
}
