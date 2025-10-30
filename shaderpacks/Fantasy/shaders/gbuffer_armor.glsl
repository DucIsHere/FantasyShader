vec3 armorReflect = auroraLight * 0.3; // mấy chi tiết kim loại
fragColor.rgb += armorReflect;
fragColor.rgb += moonColor * moonLightFactor * 0.2;
