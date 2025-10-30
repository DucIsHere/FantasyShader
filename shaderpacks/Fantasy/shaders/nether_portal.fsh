uniform float time;
uniform sampler2D noiseTex;
uniform vec3 portalColor; // vec3(0.55, 0.2, 0.9)
uniform float portalGlow; // intensity slider

void main() {
    vec2 uv = texCoord.xy * 2.0;

    // Layer 1 - năng lượng xoáy
    vec2 layer1 = uv + vec2(sin(uv.y * 3.0 + time * 1.5), cos(uv.x * 3.0 - time * 1.5)) * 0.05;
    float swirl1 = texture(noiseTex, layer1).r;

    // Layer 2 - chiều sâu ngược
    vec2 layer2 = uv * 1.3 + vec2(cos(uv.y * 2.0 - time), sin(uv.x * 2.0 + time)) * 0.04;
    float swirl2 = texture(noiseTex, layer2).r;

    // Kết hợp
    float depth = smoothstep(0.2, 0.8, swirl1 * swirl2);
    vec3 core = mix(vec3(0.05, 0.0, 0.08), portalColor, depth);

    // Nhịp sáng ma thuật
    float pulse = 0.8 + 0.2 * sin(time * 3.0);
    core *= pulse * portalGlow;

    // Viền rò rỉ năng lượng (màu lam lạnh tím)
    float edge = smoothstep(0.5, 1.0, swirl1);
    vec3 aura = vec3(0.2, 0.1, 0.4) * edge * 0.8;

    fragColor = vec4(core + aura, 1.0);
}
