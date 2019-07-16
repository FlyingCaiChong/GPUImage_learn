//
//  GPUImageCustomFeaturePointsFilter.h
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/16.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import "GPUImageFilter.h"

NS_ASSUME_NONNULL_BEGIN

@interface GPUImageCustomFeaturePointsFilter : GPUImageFilter
{
    GLint pointsUniform;
}

- (void)setFloatArray:(GLfloat *)arrayValue length:(GLsizei)arrayLength;

@end

NS_ASSUME_NONNULL_END
