//
//  GPUImageCustomSplitScreenFilter.m
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/10.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import "GPUImageCustom9SplitScreenFilter.h"

@implementation GPUImageCustom9SplitScreenFilter

- (instancetype)init
{
    if (!(self = [super initWithFragmentShaderFromFile:@"ShaderCustom9SplitScreen"])) {
        return nil;
    }
    return self;
}

@end
