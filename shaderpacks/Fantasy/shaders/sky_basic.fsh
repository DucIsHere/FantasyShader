uniform float time;
uniform sampler2D noiseTex;

void main() {
    vec2 uv = worldPos.xz * 0.0005 + vec2(0.0, time * 0.01);
    float swirl = texture(noiseTex, uv).r;
    
    // bầu trời tím đỏ đen động
    vec3 base = mix(vec3(0.08, 0.0, 0.1), vec3(0.4, 0.05, 0.15), swirl);
    vec3 glow = vec3(0.8, 0.3, 0.5) * smoothstep(0.7, 1.0, swirl);
    fragColor = vec4(base + glow * 0.3, 1.0);
}
