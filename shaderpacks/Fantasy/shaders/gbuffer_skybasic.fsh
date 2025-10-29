#include "/include/options.glsl"

void main() {
    vec2 uv = texcoord * 2.0 - 1.0;
    float t = frameTimeCounter * 0.02;
    float n = fbm(uv * 0.5 + vec2(0.0, t));

    float intensity = pow(n, 2.0) * aurora_intensity;
    vec3 auroraColor = getAuroraColor() * intensity;

    fragColor = vec4(skyColor + auroraColor, 1.0);
}
