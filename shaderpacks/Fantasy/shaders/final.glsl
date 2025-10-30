#version 150
in vec2 texcoord;
out vec4 fragColor;

uniform sampler2D colortex0;
#include "/include/options.glsl"

void main() {
    vec3 color = texture(colortex0, texcoord).rgb;
    float fog = exp(-pow(length(texcoord - 0.5), 2.0) * 2.5);
    vec3 fogColor = vec3(0.15, 0.05, 0.2);

    color = mix(color, fogColor, fog * fog_strength);
    color += pow(color, vec3(2.0)) * bloom_strength;

    fragColor = vec4(color, 1.0);
}
