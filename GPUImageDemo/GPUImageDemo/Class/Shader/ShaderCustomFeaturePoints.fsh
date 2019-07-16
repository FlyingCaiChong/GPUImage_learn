
precision highp float;

uniform sampler2D inputImageTexture;
varying vec2 textureCoordinate;

uniform lowp float points[254];
const lowp float scale = 0.003;

void main() {
    vec2 uv = textureCoordinate.xy;
    
    highp vec4 origin = texture2D(inputImageTexture, textureCoordinate);
    
    highp vec4 maskColor = vec4(1.0, 0.0, 0.0, 1.0);
  
    for (int i = 0; i < 254; i += 2) {
        //Image: (uv.x < points[i] + scale && uv.x > points[i] - scale) && (uv.y < points[i+1] + scale && uv.y > points[i+1] - scale)
        //Camera: (uv.y < points[i] + scale && uv.y > points[i] - scale) && (uv.x < points[i+1] + scale && uv.x > points[i+1] - scale)
        if ((uv.y < points[i] + scale && uv.y > points[i] - scale) && (uv.x < points[i+1] + scale && uv.x > points[i+1] - scale)) {
            gl_FragColor = origin * 0.3 + maskColor * 0.7;
            return;
        }
    }

    gl_FragColor = origin;
}
