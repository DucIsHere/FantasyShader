//////////////////////////////////
// Common
#include "/lib/common.glsl"

#ifdef FRAGMENT_SHADER

in vec2 texCoord;
flat in vec4 glColor;

// Uniforms
uniform float time;
uniform vec3 viewDir;       // Camera direction
uniform vec3 auroraColor;   // Aurora light
uniform vec3 moonColor;     // Moonlight
uniform sampler2D noiseTex; // Optional noise for animated UV

void main() {
    vec4 color = texture2D(tex, texCoord);
    color *= glColor;

    // Base glint strength
    color.rgb *= glColor.a;

    // === Multi-layer glint ===
    float flicker = 0.8 + 0.2 * sin(gl_FragCoord.x*0.1 + gl_FragCoord.y*0.1 + time*4.0);
    
    // Layer 1: Aurora glow (slow)
    vec3 layer1 = auroraColor * 0.3;
    
    // Layer 2: Moonlight glow (flicker)
    vec3 layer2 = moonColor * 0.2 * flicker;

    // Layer 3: Rim highlight (view-dependent)
    float rim = pow(1.0 - max(dot(normalize(vec3(0,0,1)), normalize(viewDir)), 0.0), 2.0);
    vec3 rimGlow = vec3(0.1, 0.05, 0.2) * rim;

    // === UV Noise animation ===
    vec2 uvAnim = texCoord + vec2(
        sin(texCoord.y*5.0 + time*1.5)*0.01,
        cos(texCoord.x*5.0 - time*1.5)*0.01
    );
    vec3 noiseLayer = texture2D(noiseTex, uvAnim).rgb * 0.1;

    // Combine all layers
    color.rgb += (layer1 + layer2 + rimGlow + noiseLayer) * glColor.a;

    gl_FragData[0] = color;
}

#endif

#ifdef VERTEX_SHADER

out vec2 texCoord;
flat out vec4 glColor;

void main() {
    gl_Position = ftransform();
    texCoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
    glColor = gl_Color;

    #if HAND_SWAYING > 0
        if (gl_ProjectionMatrix[2][2] > -0.5) {
            #include "/lib/misc/handSway.glsl"
        }
    #endif
}

#endif
