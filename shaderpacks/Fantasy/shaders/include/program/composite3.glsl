#include "/lib/common.glsl"

#ifdef FRAGMENT_SHADER
uniform sampler2D colortex0;
uniform sampler2D depthtex0;
in vec2 texCoord;

void main() {
    vec4 color = texture2D(colortex0, texCoord);
    vec4 blur = vec4(0.0);
    float offset = 1.0 / 1024.0;
    for (int i = -4; i <= 4; i++) {
    blur += texture2D(colortex0, texCoord + vec2(0.0, i * offset)) * 0.111;
}
    color = blur;


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
