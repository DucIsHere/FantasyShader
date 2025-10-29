uniform float aurora_intensity;
uniform int aurora_color;
uniform float fog_strength;
uniform float bloom_strength;

vec3 getAuroraColor() {
    if (aurora_color == 0) return vec3(0.7, 0.3, 1.0);
    if (aurora_color == 1) return vec3(0.3, 0.9, 0.6);
    if (aurora_color == 2) return vec3(0.4, 0.6, 1.0);
    return vec3(1.0, 0.8, 0.3);
}
