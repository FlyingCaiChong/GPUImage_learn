//
//  GPUImageCustomFaceChangeFilter.m
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/25.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import "GPUImageCustomFaceChangeFilter.h"

@interface GPUImageCustomFaceChangeFilter ()

@property (nonatomic, assign) CGSize frameBufferSize;

@end

@implementation GPUImageCustomFaceChangeFilter

- (instancetype)init
{
    self = [super initWithFragmentShaderFromFile:@"ShaderCustomFaceChange"];
    if (self) {
        faceArrayUniform = [filterProgram uniformIndex:@"locArray"];
        iResolutionUniform = [filterProgram uniformIndex:@"resolution"];
        haveFaceUniform = [filterProgram uniformIndex:@"haveFaceBool"];
        
        self.isHaveFace = NO;
        self.thinFaceParam = 0.0;
        self.eyeParam = 1.0;
        self.noseParam = 0.0;
    }
    return self;
}

- (void)setIsHaveFace:(BOOL)isHaveFace {
    _isHaveFace = isHaveFace;
    int value = isHaveFace == YES ? 1 : 0;
    [self setInteger:value forUniform:haveFaceUniform program:filterProgram];
}

- (void)setThinFaceParam:(CGFloat)thinFaceParam {
    _thinFaceParam = thinFaceParam;
    [self setFloat:thinFaceParam forUniformName:@"thin_face_param"];
}

- (void)setEyeParam:(CGFloat)eyeParam {
    _eyeParam = eyeParam;
    [self setFloat:eyeParam forUniformName:@"eye_param"];
}

- (void)setNoseParam:(CGFloat)noseParam {
    _noseParam = noseParam;
    [self setFloat:noseParam forUniformName:@"nose_param"];
}

- (void)setFacePointArray:(NSArray *)pointArray width:(CGFloat)width height:(CGFloat)height{
    
    if (pointArray.count == 0) {
        return;
    }
    
    static GLfloat facePoints[127 * 2] = {0};
    
//    float width = _frameBufferSize.width;
//    float height = _frameBufferSize.height;
    
    for (int index = 0; index < 127; index++) {
        CGPoint point = [pointArray[index] CGPointValue];
        // 图片
        facePoints[2 * index] = (point.x / width * 1.0);
        facePoints[2 * index + 1] = (point.y / height * 1.0);
        
        // 视频
//        facePoints[2 * index+1] =  (point.x / width * 1.0);
//        facePoints[2 * index] = 1- (point.y / height * 1.0);
    }
    
    [self setFloatVec2Array:facePoints length:127*2 forUniform:faceArrayUniform program:filterProgram];
}

- (void)setupFilterForSize:(CGSize)filterFrameSize {
    _frameBufferSize = filterFrameSize;
    [self setSize:filterFrameSize forUniform:iResolutionUniform program:filterProgram];
}

@end
