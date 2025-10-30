float fogFactor = exp(-distance * 0.02);
vec3 fogColor = mix(skyColor, auroraColor, 0.2);
fragColor.rgb = mix(fogColor, fragColor.rgb, fogFactor);
