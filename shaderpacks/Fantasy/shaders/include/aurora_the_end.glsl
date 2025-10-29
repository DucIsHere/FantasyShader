vec3 auroraColor = vec3(0.35, 0.0, 0.6);
auroraColor *= 1.5 * smoothstep(0.6, 1.0, noiseVal);
float n = fbm(uv * scale + vec2(time * 0.04, 0.0));
