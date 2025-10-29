#version 150

// === Fantasy Shader : shadow.fsh ===

in vec2 texcoord;
out vec4 fragColor;

void main() {
    // Store depth automatically by OpenGL depth buffer.
    // We can still output something to alpha channel for debug.
    fragColor = vec4(1.0); 
}
