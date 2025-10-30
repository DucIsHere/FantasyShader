float cloudShadow = 1.0 - smoothstep(0.6, 0.9, cloudDensity);
vec3 sunLight = vec3(1.0, 0.95, 0.85);
fragColor.rgb = mix(sunLight, skyColor, cloudShadow);
