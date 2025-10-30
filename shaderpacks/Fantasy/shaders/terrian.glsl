vec3 baseColor = texture(blockTex, uv).rgb;
float sunLightFactor = max(dot(normal, sunDir), 0.0);
float moonLightFactor = max(dot(normal, moonDir), 0.0);
float portalDist = length(worldPos - portalPos);
float portalAura = smoothstep(5.0, 0.0, portalDist);
fragColor.rgb += portalAura * vec3(0.25, 0.1, 0.4);

float light = max(dot(normal, sunDir), 0.0);
vec3 ambient = vec3(0.2, 0.05, 0.1);
vec3 tint = vec3(0.8, 0.3, 0.5) * 0.2; // ánh đỏ tím môi trường
fragColor.rgb = texture(blockTex, uv).rgb * (ambient + light) + tint;




// Ambient
vec3 ambient = skyColor * 0.3 + auroraColor * auroraFactor * 0.2;
fragColor.rgb = baseColor * (sunLightFactor + moonLightFactor * 0.5) + ambient;
