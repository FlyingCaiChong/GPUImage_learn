precision highp float;

uniform sampler2D inputImageTexture;

varying vec2 textureCoordinate;

uniform float Time;

void main (void) {
    
    float duration = 1.0;
    
    float maxScale = 1.2;
   
    float offset = 0.02;
    
    
    float progress = mod(Time, duration) / duration;
    
    vec2 offsetCoords = vec2(offset, offset) * progress;
    
    float scale = 1.0 + (maxScale - 1.0) * progress;
    
    
    vec2 ScaleTextureCoords = vec2(0.5, 0.5) + (textureCoordinate - vec2(0.5, 0.5)) / scale;
    
    
    vec4 maskR = texture2D(inputImageTexture, ScaleTextureCoords + offsetCoords);
    
    vec4 maskB = texture2D(inputImageTexture, ScaleTextureCoords - offsetCoords);

    vec4 mask = texture2D(inputImageTexture, ScaleTextureCoords);

    gl_FragColor = vec4(mask.r, maskR.g, maskB.b, mask.a);
    
}
