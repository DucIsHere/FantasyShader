float light = max(dot(normal, sunDir), 0.0);
vec3 ambient = vec3(0.2, 0.05, 0.1);
vec3 tint = vec3(0.8, 0.3, 0.5) * 0.2; // ánh đỏ tím môi trường
fragColor.rgb = texture(blockTex, uv).rgb * (ambient + light) + tint;
