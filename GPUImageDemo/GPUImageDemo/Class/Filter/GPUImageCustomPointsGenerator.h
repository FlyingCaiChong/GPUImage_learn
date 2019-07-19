//
//  GPUImageCustomPointsGenerator.h
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/17.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import "GPUImageFilter.h"

NS_ASSUME_NONNULL_BEGIN

@interface GPUImageCustomPointsGenerator : GPUImageFilter
{
    GLint pointWidthUniform;
    GLint pointColorUniform;
}

@property (nonatomic, assign) CGFloat pointWidth;

- (void)setPointColorRed:(GLfloat)redComponent green:(GLfloat)greenComponent blue:(GLfloat)blueComponent;

- (void)renderPointsFromArray:(GLfloat *)crosshairCoordinates count:(NSUInteger)numberOfCrosshairs frameTime:(CMTime)frameTime;

@end

NS_ASSUME_NONNULL_END
