uniform float time;
uniform vec3 moonColor;
uniform vec3 auroraColor;
uniform sampler2D glintTex; // optional, có texture glint pattern

vec2 uvAnim = uv + vec2(time * 0.3, -time * 0.2);

// Pattern glint (texture hoặc noise)
vec3 glintPattern = texture(glintTex, uvAnim).rgb;

// Glow tổng hợp
vec3 envGlow = moonColor * 0.3 + auroraColor * 0.2;
vec3 glintColor = mix(vec3(0.3,0.2,0.5), glintPattern, 0.5) + envGlow;

// Flicker nhẹ
float flicker = 0.8 + 0.2 * sin(time * 4.0 + uv.x * 5.0);
glintColor *= flicker;

// Overlay lên armor base color
fragColor.rgb = fragColor.rgb + glintColor * 0.4;
