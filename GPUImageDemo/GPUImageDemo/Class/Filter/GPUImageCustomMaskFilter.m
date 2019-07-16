//
//  GPUImageCustomMaskFilter.m
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/16.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import "GPUImageCustomMaskFilter.h"

@implementation GPUImageCustomMaskFilter

- (instancetype)init
{
    if (!(self = [super initWithFragmentShaderFromFile:@"ShaderCustomMask"])) {
        return nil;
    }
    
    maskUniform = [filterProgram uniformIndex:@"mask"];
    
    return self;
}

- (void)setMask:(CGRect)mask {
    _mask = mask;
    GPUVector4 maskVec4 = {mask.origin.x, mask.origin.y, mask.size.width, mask.size.height};
    [self setVec4:maskVec4 forUniform:maskUniform program:filterProgram];
}

@end
