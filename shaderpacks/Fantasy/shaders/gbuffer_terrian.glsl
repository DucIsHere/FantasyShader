uniform sampler2D shadowDepthTex;
uniform mat4 shadowProjection;
uniform mat4 shadowModelView;
uniform vec3 sunPosition;
uniform vec3 lightDir;

float getShadow(vec3 worldPos) {
    vec4 shadowCoord = shadowProjection * shadowModelView * vec4(worldPos, 1.0);
    shadowCoord.xyz /= shadowCoord.w;
    vec2 uv = shadowCoord.xy * 0.5 + 0.5;
    float depth = texture2D(shadowDepthTex, uv).r;
    return (shadowCoord.z - 0.002 > depth) ? 0.4 : 1.0; // 0.4 = trong bóng
}
