#version 150
#include "/lib/common.glsl"
#include "/lib/uniforms.glsl"

in vec4 worldPos;
in vec3 viewDir;

out vec4 fragColor;

uniform sampler2D noiseTex;

uniform vec3 skyColor;
uniform vec3 auroraColor;
uniform float time;

// Có thể thêm rainStrength, inSnowy... nếu cần sau này

void main() {
    // Khoảng cách từ camera đến điểm
    float distance = length(viewDir) * 0.25;

    // Độ dày sương - exponential fog
    float fogFactor = exp(-distance * 0.02);

    // Màu fog — blend aurora với trời
    vec3 fogColor = mix(skyColor, auroraColor, 0.2);

    // Base color (thường là color từ pass trước hoặc entity)
    vec3 baseColor = vec3(0.9, 0.95, 1.0);

    // Áp fog vào base
    vec3 finalColor = mix(fogColor, baseColor, fogFactor);

    // Hiệu ứng bụi / gió nhẹ bay
    float dust = texture(noiseTex, worldPos.xz * 0.002 + time * 0.02).r;
    finalColor += vec3(0.2, 0.1, 0.15) * dust * 0.1;

    // Hiệu ứng fantasy ánh sáng aurora
    finalColor += auroraColor * 0.05 * smoothstep(0.6, 1.0, dust);

    fragColor = vec4(clamp(finalColor, 0.0, 1.0), 1.0);
}
