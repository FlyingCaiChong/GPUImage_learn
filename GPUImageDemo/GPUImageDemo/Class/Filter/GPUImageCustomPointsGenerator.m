//
//  GPUImageCustomPointsGenerator.m
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/17.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import "GPUImageCustomPointsGenerator.h"

NSString *const kGPUImageCustomPointsVertexShaderString = SHADER_STRING
(
 attribute vec4 position;
 uniform float pointWidth;
 
 void main()
 {
     //     gl_Position = position;
     gl_Position = vec4(((position.xy * 2.0) - 1.0), 0.0, 1.0);
     gl_PointSize = pointWidth + 1.0;
 }
 );

NSString *const kGPUImageCustomPointsFragmentShaderString = SHADER_STRING
(
 
 uniform lowp vec3 pointColor;
 
 void main()
 {
     gl_FragColor = vec4(pointColor, 1.0);
 }
 );

@implementation GPUImageCustomPointsGenerator

- (instancetype)init
{
    if (!(self = [super initWithVertexShaderFromString:kGPUImageCustomPointsVertexShaderString fragmentShaderFromString:kGPUImageCustomPointsFragmentShaderString]))
    {
        return nil;
    }
    
    runSynchronouslyOnVideoProcessingQueue(^{
        pointWidthUniform = [filterProgram uniformIndex:@"pointWidth"];
        pointColorUniform = [filterProgram uniformIndex:@"pointColor"];
        
        self.pointWidth = 5.0;
        [self setPointColorRed:0.0 green:1.0 blue:0.0];
    });
    
    return self;
}

#pragma mark -
#pragma mark Rendering

- (void)renderCrosshairsFromArray:(GLfloat *)crosshairCoordinates count:(NSUInteger)numberOfCrosshairs frameTime:(CMTime)frameTime;
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

- (void)setPointWidth:(CGFloat)pointWidth {
    _pointWidth = pointWidth;
    [self setFloat:pointWidth forUniform:pointWidthUniform program:filterProgram];
}

- (void)setPointColorRed:(GLfloat)redComponent green:(GLfloat)greenComponent blue:(GLfloat)blueComponent {
    GPUVector3 pointColor = {redComponent, greenComponent, blueComponent};
    [self setVec3:pointColor forUniform:pointColorUniform program:filterProgram];
}

@end
