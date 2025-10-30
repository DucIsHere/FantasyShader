uniform float time;
uniform sampler2D noiseTex;

vec2 uv = texCoord.xy * 2.0 + vec2(time * 0.1, -time * 0.05);
float lavaFlow = texture(noiseTex, uv).r;

vec3 lavaColor = mix(vec3(0.4, 0.1, 0.05), vec3(1.0, 0.3, 0.1), lavaFlow);
float pulse = 0.8 + 0.2 * sin(time * 4.0);
lavaColor *= pulse;

fragColor = vec4(lavaColor, 1.0);
