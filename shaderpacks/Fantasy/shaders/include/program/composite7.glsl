#include "/lib/common.glsl"

#ifdef FRAGMENT_SHADER
uniform sampler2D colortex0;
uniform sampler2D depthtex0;
in vec2 texCoord;

void main() {
    vec4 color = texture2D(colortex0, texCoord);
    float dist = distance(texCoord, vec2(0.5));
    float vignette = smoothstep(0.7, 0.9, dist);
    color.rgb *= mix(1.0, 0.7, vignette);

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
