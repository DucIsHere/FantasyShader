#include "/lib/common.glsl"

#ifdef FRAGMENT_SHADER
uniform sampler2D colortex0;
uniform sampler2D depthtex0;
in vec2 texCoord;

void main() {
    vec4 color = texture2D(colortex0, texCoord);
    float depth = texture2D(depthtex0, texCoord).r;
    float fog = smoothstep(0.2, 1.0, depth);
    color.rgb = mix(color.rgb, vec3(0.8, 0.9, 1.0), fog * 0.3);


    // === EFFECT HERE ===

    gl_FragColor = color;
}
#endif

#ifdef VERTEX_SHADER
out vec2 texCoord;
void main() {
    gl_Position = ftransform();
    texCoord = gl_MultiTexCoord0.xy;
}
#endif
