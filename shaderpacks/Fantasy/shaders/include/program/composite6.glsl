#include "/lib/common.glsl"

#ifdef FRAGMENT_SHADER
uniform sampler2D colortex0;
uniform sampler2D depthtex0;
in vec2 texCoord;

void main() {
    vec4 color = texture2D(colortex0, texCoord);
    color.rgb = pow(color.rgb, vec3(1.1)); // tăng contrast
    color.rgb *= vec3(1.0, 0.95, 0.9);     // tint vàng nhẹ

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
