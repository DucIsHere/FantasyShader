vec3 applyLighting(vec3 color, vec3 lightColor, vec3 normal, vec3 lightDir) {
    float diff = max(dot(normal, lightDir), 0.0);
    return color * (0.5 + 0.5 * diff) * lightColor;
}

bool isLeaf = texture2D(texture, texcoord).a < 1.0; // alpha check
if (isLeaf) {
    float leafLight = 0.6 * max(dot(normal, -lightDir), 0.0);
    finalLightColor += vec3(1.0, 0.9, 0.6) * leafLight;
}

vec3(1.0, 0.7, 0.8)

float cloudShadow = getCloudShadow(worldPos, frameTimeCounter);
finalLightColor *= cloudShadow;
