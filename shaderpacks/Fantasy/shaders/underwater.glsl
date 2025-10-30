// === UNIFORMS ===
uniform float time;
uniform sampler2D causticTex;
uniform vec3 sunDir;
uniform vec3 moonDir;
uniform vec3 auroraColor;
uniform vec3 moonColor;
uniform vec3 cameraPos;

// === MAIN ===
void main() {
    vec3 baseColor = texture(blockTex, texCoord).rgb;

    // Depth-based attenuation
    float depth = gl_FragCoord.z / gl_FragCoord.w;
    float fade = exp(-depth * 0.03);

    // Caustics pattern (moving)
    vec2 cauUV = worldPos.xz * 0.02 + vec2(time * 0.2, time * 0.1);
    vec3 caustics = texture(causticTex, cauUV).rgb * 2.0;

    // Sunlight through water
    float sunFactor = max(dot(normalize(sunDir), vec3(0.0, 1.0, 0.0)), 0.0);
    vec3 sunLight = vec3(0.6, 0.8, 1.0) * sunFactor;

    // Moon + aurora reflection underwater
    vec3 auroraLight = auroraColor * 0.15;
    vec3 moonLight   = moonColor * 0.25;

    // Combine all
    vec3 lightColor = sunLight + moonLight + auroraLight;
    vec3 waterColor = mix(vec3(0.0, 0.15, 0.25), lightColor, 0.2);

    // Apply caustics + attenuation
    vec3 finalColor = baseColor * (lightColor + caustics * 0.3);
    finalColor = mix(waterColor, finalColor, fade);

    fragColor = vec4(finalColor, 1.0);
}
