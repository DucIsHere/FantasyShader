#ifdef FRAGMENT_SHADER

in vec2 texCoord;
flat in vec4 glColor;

uniform float time;
uniform sampler2D noiseTex;

void main() {
    vec2 uv = texCoord;

    // Xoáy năng lượng
    vec2 swirl = uv + vec2(sin(uv.y*10.0 + time*2.0), cos(uv.x*10.0 - time*2.0))*0.05;
    float noiseVal = texture(noiseTex, swirl).r;

    // Base color tím deep
    vec3 baseColor = mix(vec3(0.05,0.0,0.1), vec3(0.6,0.1,0.7), noiseVal);

    // Glow nhịp
    float pulse = 0.7 + 0.3*sin(time*3.0);
    baseColor *= pulse;

    fragColor = vec4(baseColor, 1.0);
}

#endif
