vec3 color = vec3(0.1, 0.8, 1.0); // light cyan-blue
auroraColor *= 1.5 * smoothstep(0.6, 1.0, noiseVal);
float n = fbm(uv * scale + vec2(time * 0.04, 0.0));
float n2 = fbm(uv * scale * 0.4 - vec2(time * 0.015, 0.0));
float auroraWave = mix(n, n2, 0.5);
float flicker = 0.9 + 0.1 * sin(time * 0.8); // Flicker Smooth
color *= flicker;
color *= smoothstep(0.0, 0.6, 1.0 - abs(uv.y)); // Fade Horizons
