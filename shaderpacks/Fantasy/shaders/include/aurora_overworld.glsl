vec3 color = vec3(0.1, 0.8, 1.0); // light cyan-blue
auroraColor *= 1.5 * smoothstep(0.6, 1.0, noiseVal);
float n = fbm(uv * scale + vec2(time * 0.04, 0.0));
