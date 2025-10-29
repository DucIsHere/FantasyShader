#version 150

// === Fantasy Shader : shadow.vsh ===

in vec3 vaPosition;
in vec2 vaUV0;

uniform mat4 shadowProjection;
uniform mat4 shadowModelView;

out vec2 texcoord;

void main() {
    texcoord = vaUV0;
    gl_Position = shadowProjection * shadowModelView * vec4(vaPosition, 1.0);
}
