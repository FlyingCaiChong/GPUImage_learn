precision highp float;
uniform sampler2D inputImageTexture;
varying vec2 textureCoordinate;

void main() {
    
    vec2 uv = textureCoordinate.xy;
    
    if (uv.x >= 0.0 && uv.x < 1.0/3.0) {
        uv.x = 3.0 * uv.x;
    } else if (uv.x >= 1.0/3.0 && uv.x < 2.0/3.0) {
        uv.x = 3.0 * (uv.x - 1.0/3.0);
    } else {
        uv.x = 3.0 * (uv.x - 2.0/3.0);
    }
    
    if (uv.y >= 0.0 && uv.y < 1.0/3.0) {
        uv.y = 3.0 * uv.y;
    } else if (uv.y >= 1.0/3.0 && uv.y < 2.0/3.0) {
        uv.y = 3.0 * (uv.y - 1.0/3.0);
    } else {
        uv.y = 3.0 * (uv.y - 2.0/3.0);
    }
    
    gl_FragColor = texture2D(inputImageTexture, uv);
}
