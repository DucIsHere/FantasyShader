#include "/include/options.glsl"

void main() {
    vec2 uv = texcoord * 2.0 - 1.0;
    float t = frameTimeCounter * 0.02;
    float n = fbm(uv * 0.5 + vec2(0.0, t));

    float intensity = pow(n, 2.0) * aurora_intensity;
    vec3 auroraColor = getAuroraColor() * intensity;

    fragColor = vec4(skyColor + auroraColor, 1.0);
}

#version 150
in vec2 texcoord;
out vec4 fragColor;

uniform sampler2D texture;
uniform vec3 lightDir;
uniform vec3 skyColor;
uniform float frameTimeCounter;

#include "/include/lighting.glsl"
#include "/include/water_reflect.glsl"

void main() {
    vec3 base = texture2D(texture, texcoord).rgb;
    vec3 normal = vec3(0.0, 1.0, 0.0);
    vec3 lightColor = vec3(1.0, 0.95, 0.8);

    vec3 lit = applyLighting(base, lightColor, normal, lightDir);
    vec3 reflect = waterReflection(normalize(vec3(0.0, 1.0, 0.0)), normal, skyColor, texcoord, frameTimeCounter);

    fragColor = vec4(lit + reflect, 1.0);
}
