#version 150
#include "/lib/common.glsl"
#include "/lib/uniforms.glsl"

in vec2 texcoord;
in vec3 normal;
in vec3 viewDir;
in vec4 worldPos;

out vec4 fragColor;

uniform sampler2D reflectTex;
uniform sampler2D refractTex;

uniform vec3 skyColor;
uniform vec3 auroraColor;
uniform vec3 moonColor;

void main() {
    // -------------------------------
    // Chuẩn hóa normal & hướng nhìn
    vec3 N = normalize(normal);
    vec3 V = normalize(viewDir);

    // Fresnel cơ bản
    float fresnel = pow(1.0 - max(dot(N, V), 0.0), 3.0);

    // Toạ độ phản chiếu/khúc xạ
    vec2 reflectCoord = texcoord + N.xz * 0.02;
    vec2 refractCoord = texcoord - N.xz * 0.015;

    // Lấy texture reflection & refraction
    vec3 refl = texture(reflectTex, reflectCoord).rgb;
    vec3 refr = texture(refractTex, refractCoord).rgb;

    // Ánh sáng aurora và trăng phản xuống
    vec3 auroraRefl = auroraColor * 0.5 * smoothstep(0.2, 1.0, fresnel);
    vec3 moonRefl   = moonColor * 0.3 * fresnel;
    vec3 skyRefl    = skyColor * 0.25 * fresnel;

    // Blend nước cơ bản
    vec3 base = mix(refr, refl, fresnel);

    // Fantasy tint (xanh trắng lung linh)
    vec3 fantasyTint = vec3(0.9, 0.95, 1.1);
    base *= fantasyTint;

    // Gộp tất cả
    vec3 finalColor = base + auroraRefl + moonRefl + skyRefl;

    // Làm mềm & clamp
    fragColor = vec4(clamp(finalColor, 0.0, 1.0), 1.0);
}
