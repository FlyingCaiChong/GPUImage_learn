//
//  GPUImageCustomScaleFilter.m
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/12.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import "GPUImageCustomScaleFilter.h"
NSString *const kGPUImageCustomScaleVertexShaderString = SHADER_STRING
(
 attribute vec4 position;
 attribute vec4 inputTextureCoordinate;
 varying vec2 textureCoordinate;
 
 void main() {
     gl_Position = position;
     textureCoordinate = inputTextureCoordinate.xy;
 }
 );

NSString *const kGPUImageCustomScaleFragmentShaderString = SHADER_STRING
(
 precision highp float;
 uniform sampler2D inputImageTexture;
 varying vec2 textureCoordinate;
 
 uniform float Time;
 
 void main() {
     
     float duration = 1.0;
     float maxAlpha = 0.5;
     float maxScale = 1.8;
     float progress = mod(Time, duration)/duration;
     float alpha = maxAlpha * (1.0 - progress);
     float scale = 1.0 + (maxScale-1.0)*progress;
     float weakX = 0.5 + (textureCoordinate.x - 0.5) / scale;
     float weakY = 0.5 + (textureCoordinate.y - 0.5) / scale;
     vec2 weakTextureCoords = vec2(weakX, weakY);
     vec4 weakMask = texture2D(inputImageTexture, weakTextureCoords);
     vec4 mask = texture2D(inputImageTexture, textureCoordinate);
     gl_FragColor = mask * (1.0 - alpha) + weakMask * alpha;
 }
 );

@implementation GPUImageCustomScaleFilter

#pragma mark -
#pragma mark Initialization
- (instancetype)init {
    if (!(self = [super initWithVertexShaderFromString:kGPUImageCustomScaleVertexShaderString fragmentShaderFromString:kGPUImageCustomScaleFragmentShaderString])) {
        return nil;
    }
    
    timeUniform = [filterProgram uniformIndex:@"Time"];
    self.time = 0.0;
    
    return self;
}

#pragma mark -
#pragma mark Accessors
- (void)setTime:(CGFloat)time {
    _time = time;
    [self setFloat:_time forUniform:timeUniform program:filterProgram];
}

@end
