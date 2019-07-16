
precision highp float;

uniform sampler2D inputImageTexture;
varying vec2 textureCoordinate;

uniform lowp vec4 mask;

void main() {
    vec2 uv = textureCoordinate.xy;
    
    highp vec4 origin = texture2D(inputImageTexture, textureCoordinate);
    
    highp vec4 maskColor = vec4(1.0, 0.0, 0.0, 1.0);
    // uv.y < (mask.x + mask.z) && uv.x < (mask.y + mask.w) && uv.y > mask.x && uv.x > mask.y
//     uv.x < (mask.x + mask.z) && uv.y < (mask.y + mask.w) && uv.x > mask.x && uv.y > mask.y
    if(uv.y < (mask.x + mask.z) && uv.x < (mask.y + mask.w) && uv.y > mask.x && uv.x > mask.y) {
        gl_FragColor = origin * 0.3 + maskColor * 0.7;
    }else {
        gl_FragColor = origin;
    }
}
