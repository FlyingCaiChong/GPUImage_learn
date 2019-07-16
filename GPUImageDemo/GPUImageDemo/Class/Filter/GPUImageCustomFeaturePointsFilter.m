//
//  GPUImageCustomFeaturePointsFilter.m
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/16.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import "GPUImageCustomFeaturePointsFilter.h"

@implementation GPUImageCustomFeaturePointsFilter

- (instancetype)init
{
    if (!(self = [super initWithFragmentShaderFromFile:@"ShaderCustomFeaturePoints"])) {
        return nil;
    }
    
    pointsUniform = [filterProgram uniformIndex:@"points"];
    
    return self;
}

- (void)setFloatArray:(GLfloat *)arrayValue length:(GLsizei)arrayLength {
    [self setFloatArray:arrayValue length:arrayLength forUniform:pointsUniform program:filterProgram];
}

@end
