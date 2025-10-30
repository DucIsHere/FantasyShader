float flicker = 0.8 + 0.2 * sin(time * 3.0 + gl_FragCoord.x * 0.1);
fragColor.rgb = vec3(0.6, 0.2, 0.4) * flicker;
fragColor.a = 0.6;
