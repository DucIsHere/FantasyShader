//////////////////////////////////
// Fantasy Shader Composite N
// Base by m, hiệu ứng nhét sau
//////////////////////////////////

#include "/lib/common.glsl"

#ifdef FRAGMENT_SHADER

//==== Uniforms ====//
uniform sampler2D colortex0; // main color
uniform sampler2D depthtex0; // depth
uniform sampler2D colortex1; // optional (bloom, glow, etc)
uniform vec2 texelSize;
uniform float viewWidth;
uniform float viewHeight;
uniform float frameTimeCounter;
uniform float aspectRatio;

//==== Inputs ====//
in vec2 texCoord;

//==== Main ====//
void main() {
    vec4 color = texture2D(colortex0, texCoord);
    float depth = texture2D(depthtex0, texCoord).r;

    vec4 blur = vec4(0.0);
    float offset = 1.0 / 1024.0;
    for (int i = -4; i <= 4; i++) {
    blur += texture2D(colortex0, texCoord + vec2(i * offset, 0.0)) * 0.111;
    }
    color = blur;


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
