vec3 bloom = smoothstep(0.8, 1.0, color.rgb) * 0.2;
color.rgb += bloom + auroraColor * 0.05;
