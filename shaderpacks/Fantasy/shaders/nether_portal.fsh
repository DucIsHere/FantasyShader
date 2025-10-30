uniform float time;
uniform vec3 cameraPos;
uniform vec3 portalColor;   // thường là vec3(0.6, 0.2, 0.9)
uniform sampler2D noiseTex; // noise động
uniform float portalIntensity; // chỉnh bằng option

void main() {
    vec2 uv = texCoord.xy;

    // Hiệu ứng nhiễu động portal
    vec2 wave = uv + vec2(
        sin(uv.y * 8.0 + time * 2.0),
        cos(uv.x * 8.0 - time * 2.0)
    ) * 0.02;

    // Nhiễu sâu (layer 2)
    float depthWave = texture(noiseTex, uv * 2.0 + time * 0.1).r;
    float glowPulse = 0.7 + 0.3 * sin(time * 2.0);

    // Màu portal cơ bản
    vec3 baseColor = mix(
        vec3(0.1, 0.0, 0.15), // vùng rìa tối
        portalColor,           // vùng sáng
        smoothstep(0.2, 0.8, depthWave)
    );

    // Độ sáng và chuyển động
    baseColor *= glowPulse * portalIntensity;

    // Vẽ thêm layer aurora tím nhạt (dark fantasy touch)
    vec2 aurUV = uv * 0.5 + vec2(0.0, time * 0.03);
    vec3 auroraGlow = texture(noiseTex, aurUV).rgb;
    auroraGlow = mix(vec3(0.0), vec3(0.4, 0.1, 0.6), auroraGlow.r);

    vec3 finalColor = baseColor + auroraGlow * 0.4;

    fragColor = vec4(finalColor, 1.0);
}
