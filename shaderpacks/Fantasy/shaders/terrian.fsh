vec3 baseColor = texture(blockTex, uv).rgb;
float sunLightFactor = max(dot(normal, sunDir), 0.0);
float moonLightFactor = max(dot(normal, moonDir), 0.0);
// trong terrain.fsh
float portalProximity = smoothstep(3.0, 0.0, distance(worldPos, portalPos));
fragColor.rgb += portalProximity * vec3(0.3, 0.1, 0.5);


// Ambient
vec3 ambient = skyColor * 0.3 + auroraColor * auroraFactor * 0.2;
fragColor.rgb = baseColor * (sunLightFactor + moonLightFactor * 0.5) + ambient;
