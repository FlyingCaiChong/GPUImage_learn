//
//  GPUImageCustomLipstickGenerator.m
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/17.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import "GPUImageCustomLipstickGenerator.h"

NSString *const kGPUImageCustomLipstickVertexShaderString = SHADER_STRING
(
 attribute vec4 position;
 
 varying vec2 textureCoordinate;
 
// const int SHIFT_SIZE = 2;
 uniform float texelWidthOffset;
 uniform float texelHeightOffset;
// varying vec4 blurShiftCoordinates[SHIFT_SIZE];
 
 void main()
 {
     gl_Position = position;
//     gl_Position = vec4(((position.xy * 2.0) - 1.0), 0.0, 1.0);
     gl_PointSize = 3.0;
     vec2 coordinate = position.xy * 0.5 + 0.5;
     float y = 1.0 - coordinate.y;
     if (y < 0.0) {
         y = 0.0;
     }
     if (y > 1.0) {
         y = 1.0;
     }
     textureCoordinate = vec2(coordinate.x, y);
     
//     vec2 singleStepOffset = vec2(texelWidthOffset, texelHeightOffset);
//
//     for (int i = 0, i < SHIFT_SIZE, i++) {
//         blurShiftCoordinates[i] = vec4(textureCoordinate.xy - float(i + 1) * singleStepOffset, textureCoordinate.xy + float(i + 1) * singleStepOffset);
//     }
 }
 );

NSString *const kGPUImageCustomLipstickFragmentShaderString = SHADER_STRING
(
 
 varying highp vec2 textureCoordinate;
 
 uniform sampler2D inputImageTexture;
 uniform lowp vec3 offsetColor;
 uniform mediump float strength;
 
// const int SHIFT_SIZE = 2;
// varying highp vec4 blurShiftCoordinates[SHIFT_SIZE];
 
 void main()
 {
     lowp vec3 sourceColor = texture2D(inputImageTexture, textureCoordinate.xy).rgb;
     lowp vec3 dstColor = sourceColor + offsetColor;
//     lowp vec4 currentColor = vec4(dstColor * 0.5 + sourceColor * 0.5, strength);
     gl_FragColor = vec4(dstColor * 0.5 + sourceColor * 0.5, strength);
//     mediump vec3 sum = currentColor.rgb;
     
//     for (int i = 0; i < SHIFT_SIZE; i++) {
//         sum += texture2D(inputImageTexture, blurShiftCoordinates[i].xy).rgb;
//         sum += texture2D(inputImageTexture, blurShiftCoordinates[i].zw).rgb;
//     }
     
//     gl_FragColor = vec4(sum * 1.0 / float(2 * SHIFT_SIZE + 1), currentColor.a);
 }
 );

@implementation GPUImageCustomLipstickGenerator

- (instancetype)init
{
    if (!(self = [super initWithVertexShaderFromString:kGPUImageCustomLipstickVertexShaderString fragmentShaderFromString:kGPUImageCustomLipstickFragmentShaderString]))
    {
        return nil;
    }
    
    runSynchronouslyOnVideoProcessingQueue(^{
        
        texelWidthOffsetUniform = [filterProgram uniformIndex:@"texelWidthOffset"];
        texelHeightOffsetUniform = [filterProgram uniformIndex:@"texelHeightOffset"];
        strengthUniform = [filterProgram uniformIndex:@"strength"];
        offsetColorUniform = [filterProgram uniformIndex:@"offsetColor"];
        
        self.texelWidthOffset = 1.0;
        self.texelHeightOffset = 1.0;
        self.strength = 1.0;
        [self setColorRed:1.0 green:0.0 blue:0.0];
    });
    
    return self;
}

#pragma mark -
#pragma mark Rendering

- (void)renderLipstickFromArray:(GLfloat *)crosshairCoordinates count:(NSUInteger)numberOfCrosshairs frameTime:(CMTime)frameTime
{
    if (self.preventRendering)
    {
        return;
    }
    
    runSynchronouslyOnVideoProcessingQueue(^{
        [GPUImageContext setActiveShaderProgram:filterProgram];
        
#if TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE
#else
        glEnable(GL_POINT_SPRITE);
        glEnable(GL_VERTEX_PROGRAM_POINT_SIZE);
#endif
        
        outputFramebuffer = [[GPUImageContext sharedFramebufferCache] fetchFramebufferForSize:[self sizeOfFBO] textureOptions:self.outputTextureOptions onlyTexture:NO];
        [outputFramebuffer activateFramebuffer];
        
        glClearColor(0.0, 0.0, 0.0, 0.0);
        glClear(GL_COLOR_BUFFER_BIT);
        
        glVertexAttribPointer(filterPositionAttribute, 2, GL_FLOAT, 0, 0, crosshairCoordinates);
        
        glDrawArrays(GL_POINTS, 0, (GLsizei)numberOfCrosshairs);
        
        [self informTargetsAboutNewFrameAtTime:frameTime];
    });
}

- (void)renderToTextureWithVertices:(const GLfloat *)vertices textureCoordinates:(const GLfloat *)textureCoordinates;
{
    // Prevent rendering of the frame by normal means
}


- (void)setTexelWidthOffset:(CGFloat)texelWidthOffset {
    _texelWidthOffset = texelWidthOffset;
    [self setFloat:texelWidthOffset forUniform:texelWidthOffsetUniform program:filterProgram];
}

- (void)setTexelHeightOffset:(CGFloat)texelHeightOffset {
    _texelHeightOffset = texelHeightOffset;
    [self setFloat:texelHeightOffset forUniform:texelHeightOffsetUniform program:filterProgram];
}

- (void)setStrength:(CGFloat)strength {
    _strength = strength;
    [self setFloat:strength forUniform:strengthUniform program:filterProgram];
}

- (void)setColorRed:(GLfloat)redComponent green:(GLfloat)greenComponent blue:(GLfloat)blueComponent {
    
    GPUVector3 color = {redComponent, greenComponent, blueComponent};
    [self setVec3:color forUniform:offsetColorUniform program:filterProgram];
}

@end
