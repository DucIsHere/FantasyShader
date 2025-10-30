vec3 refl = texture(reflectTex, reflectCoord).rgb;
vec3 refr = texture(refractTex, refractCoord).rgb;

// Ánh sáng aurora và trăng phản xuống
vec3 auroraRefl = auroraColor * 0.5;
vec3 moonRefl   = moonColor * 0.3;

// Combine
fragColor.rgb = mix(refr, refl, fresnel) + auroraRefl + moonRefl;
