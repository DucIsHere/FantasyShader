float dist = length(worldPos - cameraPos);
float fogFactor = exp(-dist * 0.05);
vec3 fogColor = mix(vec3(0.15, 0.0, 0.1), vec3(0.4, 0.1, 0.15), 0.5);
fragColor.rgb = mix(fogColor, fragColor.rgb, fogFactor);
