
precision mediump float;

varying highp vec2 textureCoordinate;
uniform sampler2D inputImageTexture;

uniform float thin_face_param;

uniform float eye_param;

uniform float nose_param;

uniform vec2 resolution;
uniform int hasFaceBool;

uniform mediump vec2 locArray[127];

highp vec2 warpPositionToUse1(vec2 currentPoint, vec2 contourPointA, vec2 contourPointB, float radius, float delta, float aspectRatio)
{
    highp vec2 positionToUse = currentPoint;
    
    vec2 currentPointToUse = vec2(currentPoint.x, currentPoint.y * aspectRatio + 0.5 - 0.5 * aspectRatio);
    vec2 contourPointAToUse = vec2(contourPointA.x, contourPointA.y * aspectRatio + 0.5 - 0.5 * aspectRatio);
    highp float r = distance(currentPointToUse, contourPointAToUse);
    
    if (r < radius) {
        vec2 dir = normalize(contourPointB - contourPointA);
        float dist = radius * radius - r * r;
        float alpha = dist / (dist + (r - delta) * (r - delta));
        alpha = alpha * alpha;
        
        positionToUse = positionToUse - alpha * delta * dir;
    }
    
    return positionToUse;
}

vec2 adjust_thinFace(vec2 coord, float eye_dist, vec2 dir_up, vec2 dir_right, float aspect_ratio, float intensity)
{
    vec2 positionToUse = coord;
    int arraySize = 3;
    vec2 leftContourPoints[3];
    vec2 rightContourPoints[3];
    
    float deltaArray[3];
    
    leftContourPoints[0] = locArray[3] - dir_right * eye_dist * 0.13;
    leftContourPoints[1] = locArray[5] - dir_right * eye_dist * 0.33;
    leftContourPoints[2] = locArray[7] - dir_right * eye_dist * 0.33;
    
    rightContourPoints[0] = locArray[13] - dir_right * eye_dist * 0.13;
    rightContourPoints[1] = locArray[11] - dir_right * eye_dist * 0.33;
    rightContourPoints[2] = locArray[9] - dir_right * eye_dist * 0.33;
    
    float x = 3.14159 / 30.0;
    float scaleFactor = eye_dist * 2.0;
    float radius = 0.4 * scaleFactor;
    
    deltaArray[0] = sin(x) * intensity * 0.150 * scaleFactor;
    deltaArray[1] = sin(x * 2.0) * intensity * 0.150 * scaleFactor;
    deltaArray[2] = sin(x * 2.0) * intensity * 0.150 * scaleFactor;
    
    for (int i = 0; i < arraySize; i++) {
        positionToUse = warpPositionToUse1(positionToUse, leftContourPoints[i], rightContourPoints[i], radius, deltaArray[i], aspect_ratio);
        positionToUse = warpPositionToUse1(positionToUse, leftContourPoints[i], rightContourPoints[i], radius, deltaArray[i], aspect_ratio);
    }
    
    return positionToUse;
}

vec2 adjust_eye(vec2 coord, float eye_dist, vec2 dir_up, vec2 dir_right, float aspect_ratio, float intensity)
{
    float eyeEnlarge = intensity * 0.24;
    
    float res_ratio = resolution.x / resolution.y;
    
    vec2 newCoord = vec2(coord.x * res_ratio, coor.y);
    
    vec2 eyea = vec2(locArray[98].x * res_ratio, locArray[98].y);
    vec2 eyeb = vec2(locArray[103].x * res_ratio, locArray[103].y);
    
    vec2 eye_far = vec2(locArray[36].x * res_ratio, locArray[36].y);
    vec2 eye_near = vec2(locArray[39].x * res_ratio, locArray[39].y);
    
    float weight = 0.0;
    float eye_width = distance(eye_far, eye_near);
    
    float eyeRadius = eye_width;
    float dis_eye1 = distance(newCoord, eyea);
    if (dis_eye1 < 0.01) {
        
        weight = pow((dis_eye1 + 0.01) / eyeRadius, eyeEnlarge);
        newCoord = eyea + (newCoord - eyea) * weight;
    } else if (dis_eye1 <= eyeRadius) {
        
        weight = pow(dis_eye1 / eyeRadius, eyeEnlarge);
        newCoord = eyea + (newCoord - eyea) * weight;
    }
    
    float dis_eye2 = distance(newCoord, eyeb);
    if (dis_eye2 < 0.01) {
        
        weight = pow((dis_eye2 + 0.01) / eyeRadius, eyeEnlarge);
        newCoord = eyeb + (newCoord - eyeb) * weight;
    } else if (dis_eye2 <= eyeRadius) {
        
        weight = pow(dis_eye2 / eyeRadius, eyeEnlarge);
        newCoord = eyeb + (newCoord - eyeb) * weight;
    }
    
    newCoord = vec2(newCoord.x / res_ratio, newCoord.y);
    return newCoord;
}

vec2 newNarrowNose_2(vec2 coord, float eye_dist, vec2 dir_up, vec2 dir_right, float aspect_ratio, float intensity)
{
    vec2 positionToUse = coord;
    float scaleFactor = eye_dist * 0.28;
    float noseMorph = intensity * scaleFactor;
    
    int arraySize = 2;
    float radius = 0.16;
    float delta = noseMorph * scaleFactor;
    
    vec2 left_loca = locArray[32] + dir_up * 0.09;
    vec2 right_loca = locArray[34] + dir_up * 0.09;
    
    vec2 leftContourPoints[2];
    leftContourPoints[0] = left_loca;
    leftContourPoints[1] = locArray[117];
    
    vec2 rightContourPoints[2];
    rightContourPoints[0] = right_loca;
    rightContourPoints[1] = locArray[121];
    
    for (int i = 0; i < arraySize; i++) {
        positionToUse = warpPositionToUse1(positionToUse, leftContourPoints[i], rightContourPoints[i], radius, delta, aspect_ratio);
        positionToUse = warpPositionToUse1(positionToUse, rightContourPoints[i], leftContourPoints[i], radius, delta, aspect_ratio);
    }
    
    return positionToUse;
}

void main()
{
    vec2 newCoord = textureCoordinate;
    
    highp float eye_dist = distance(locArray[98], locArray[103]);
    highp float aspect_ratio = resolution.y / resolution.x;
    
    vec2 dir_up = normalize(locArray[27] - locArray[8]);
    vec2 dir_right = normalize(locArray[103] - locArray[98]);
    
    if (haveFaceBool == 1) {
        newCoord = adjust_thinFace(newCoord, eye_dist, dir_up, dir_right, aspect_ratio, thin_face_param);
        newCoord = adjust_eye(newCoord, eye_dist, dir_up, dir_right, aspect_ratio, eye_param);
        newCoord = newNarrowNose_2(newCoord, eye_dist, dir_up, dir_right, aspect_ratio, nose_param);
    }
    
    vec3 newColor = texture2D(inputImageTexture, newCoord).rgb;
    gl_FragColor = vec4(newColor, 1.0);
}
