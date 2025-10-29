uniform float temperature;   // để kiểm tra snowy biome
uniform float rainStrength;  // trời mưa hay không
uniform sampler2D auroraMap; // nếu m dùng texture/noise
uniform vec3 moonDir;
uniform vec3 moonColor;

// ánh sáng trăng
float moonLightFactor = max(dot(normal, moonDir), 0.0);

// aurora chỉ hiện trong snowy biome và trời quang
float auroraFactor = (temperature < 0.3 && rainStrength < 0.1) ? 1.0 : 0.0;
vec3 auroraLight = auroraFactor * texture(auroraMap, uv).rgb;

// combine ánh sáng môi trường
vec3 finalEnvLight = auroraLight + moonColor * moonLightFactor;

// nhân vào color entity
fragColor.rgb = fragColor.rgb * finalEnvLight;

float rim = pow(max(dot(viewDir, normal), 0.0), 2.0);
fragColor.rgb += rim * 0.2 * moonColor;
