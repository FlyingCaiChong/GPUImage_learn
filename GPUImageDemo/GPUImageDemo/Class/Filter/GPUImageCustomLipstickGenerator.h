//
//  GPUImageCustomLipstickGenerator.h
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/17.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import "GPUImageFilter.h"

NS_ASSUME_NONNULL_BEGIN

@interface GPUImageCustomLipstickGenerator : GPUImageFilter
{
    GLint texelWidthOffsetUniform;
    GLint texelHeightOffsetUniform;
    GLint offsetColorUniform;
    GLint strengthUniform;
}

@property (nonatomic, assign) CGFloat texelWidthOffset;
@property (nonatomic, assign) CGFloat texelHeightOffset;
@property (nonatomic, assign) CGFloat strength;

- (void)setColorRed:(GLfloat)redComponent green:(GLfloat)greenComponent blue:(GLfloat)blueComponent;

- (void)renderLipstickFromArray:(GLfloat *)crosshairCoordinates count:(NSUInteger)numberOfCrosshairs frameTime:(CMTime)frameTime;

@end

NS_ASSUME_NONNULL_END
