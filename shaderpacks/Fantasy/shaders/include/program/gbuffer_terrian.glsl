#version 150
#include "/lib/common.glsl"
#include "/lib/uniforms.glsl"

in vec3 worldPos;
in vec3 normal;
in vec2 uv;

out vec4 fragColor;

uniform sampler2D blockTex;
uniform sampler2D shadowDepthTex;

uniform mat4 shadowProjection;
uniform mat4 shadowModelView;

uniform vec3 sunDir;
uniform vec3 moonDir;
uniform vec3 portalPos;
uniform vec3 skyColor;
uniform vec3 auroraColor;

float getShadow(vec3 worldPos) {
    vec4 shadowCoord = shadowProjection * shadowModelView * vec4(worldPos, 1.0);
    shadowCoord.xyz /= shadowCoord.w;
    vec2 uv = shadowCoord.xy * 0.5 + 0.5;
    float depth = texture2D(shadowDepthTex, uv).r;
    return (shadowCoord.z - 0.002 > depth) ? 0.4 : 1.0; // 0.4 = trong bóng
}

void main() {
    // Base texture
    vec3 baseColor = texture(blockTex, uv).rgb;

    // Ánh sáng
    float sunLight = max(dot(normal, sunDir), 0.0);
    float moonLight = max(dot(normal, moonDir), 0.0);
    float shadow = getShadow(worldPos);

    // Ambient kiểu fantasy (mix aurora & sky)
    float auroraFactor = clamp(dot(normal, vec3(0.0, 1.0, 0.0)), 0.0, 1.0);
    vec3 ambient = skyColor * 0.25 + auroraColor * auroraFactor * 0.15;

    // Màu ánh sáng cơ bản
    vec3 lightColor = vec3(1.0, 0.9, 0.85);
    vec3 moonColor  = vec3(0.5, 0.6, 0.8);

    // Portal aura (dark fantasy tím hồng)
    float portalDist = length(worldPos - portalPos);
    float portalAura = smoothstep(6.0, 0.0, portalDist);
    vec3 portalGlow = vec3(0.25, 0.1, 0.4) * portalAura;

    // Combine ánh sáng + ambient + bóng
    vec3 lighting = ambient
                  + (sunLight * lightColor + moonLight * moonColor * 0.4) * shadow;

    vec3 finalColor = baseColor * lighting + portalGlow;

    fragColor = vec4(clamp(finalColor, 0.0, 1.0), 1.0);
}
