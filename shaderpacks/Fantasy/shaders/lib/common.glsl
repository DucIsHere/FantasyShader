//////////////////////////////////
// COMMON GLSL LIBRARY
//////////////////////////////////

// === Uniforms cơ bản ===
uniform float time;          // Thời gian global
uniform vec3 cameraPos;      // Vị trí camera
uniform vec3 sunDir;         // Vector ánh sáng mặt trời
uniform vec3 moonDir;        // Vector ánh sáng trăng
uniform vec3 auroraColor;    // Màu Aurora
uniform vec3 moonColor;      // Màu Moonlight

// === Helpers ===
vec3 applyGamma(vec3 color, float gamma) {
    return pow(color, vec3(1.0/gamma));
}

float linearizeDepth(float depth) {
    return depth / gl_FragCoord.w;
}

// === Noise functions ===
float rand(vec2 co) {
    return fract(sin(dot(co.xy, vec2(12.9898,78.233))) * 43758.5453);
}

float noise(vec2 uv) {
    vec2 i = floor(uv);
    vec2 f = fract(uv);

    // Four corners
    float a = rand(i);
    float b = rand(i + vec2(1.0,0.0));
    float c = rand(i + vec2(0.0,1.0));
    float d = rand(i + vec2(1.0,1.0));

    vec2 u = f*f*(3.0-2.0*f);
    return mix(a, b, u.x) + (c-a)*u.y*(1.0-u.x) + (d-b)*u.x*u.y;
}

// === Fresnel Rim ===
float rimFactor(vec3 normal, vec3 viewDir, float power) {
    return pow(1.0 - max(dot(normal, normalize(viewDir)), 0.0), power);
}

// === Macro for Minecraft hand swaying ===
#if HAND_SWAYING > 0
    #define HAND_SWAY if(gl_ProjectionMatrix[2][2] > -0.5) { #include "/lib/misc/handSway.glsl" }
#else
    #define HAND_SWAY
#endif

//////////////////////////////////
// END COMMON.GLSL
//////////////////////////////////
