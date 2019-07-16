//
//  GPUImageCustomIllusionFilter.m
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/12.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import "GPUImageCustomIllusionFilter.h"

@implementation GPUImageCustomIllusionFilter

- (instancetype)init
{
    if (!(self = [super initWithFragmentShaderFromFile:@"ShaderCustomIllusion"])) {
        return nil;
    }
    
    
    timeUniform = [filterProgram uniformIndex:@"Time"];
    self.time = 0.0;
    
    return self;
}

- (void)setTime:(CGFloat)time {
    _time = time;
    [self setFloat:_time forUniform:timeUniform program:filterProgram];
}

@end
