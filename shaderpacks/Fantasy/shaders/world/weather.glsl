float fogFactor = exp(-distance * 0.02);
vec3 fogColor = mix(skyColor, auroraColor, 0.2);
fragColor.rgb = mix(fogColor, fragColor.rgb, fogFactor);
float dust = texture(noiseTex, vec2(worldPos.xz * 0.002 + time * 0.02)).r;
fragColor.rgb += vec3(0.2, 0.1, 0.15) * dust * 0.1;
