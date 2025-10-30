vec2 uvAnim = uv + vec2(sin(time*2.0 + uv.y*10.0)*0.02, 0.0);
vec3 beamColor = mix(vec3(0.2,0.3,1.0), vec3(0.5,0.6,1.0), texture(noiseTex, uvAnim).r);
color.rgb += beamColor * glowFactor;
