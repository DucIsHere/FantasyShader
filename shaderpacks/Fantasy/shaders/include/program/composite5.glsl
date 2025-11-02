#include "/lib/common.glsl"

#ifdef FRAGMENT_SHADER
uniform sampler2D colortex0;
uniform sampler2D depthtex0;
in vec2 texCoord;

void main() {
    vec4 color = texture2D(colortex0, texCoord);
    float wave = sin(texCoord.y * 20.0 + frameTimeCounter * 0.8) * 0.5 + 0.5;
    vec3 aurora = vec3(0.4, 0.7, 1.0) * wave * 0.15;
    color.rgb += aurora;

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
