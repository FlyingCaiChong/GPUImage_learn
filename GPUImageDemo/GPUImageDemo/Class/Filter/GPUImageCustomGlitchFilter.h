//
//  GPUImageCustomIllusoryFilter.h
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/12.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import "GPUImageFilter.h"

NS_ASSUME_NONNULL_BEGIN
// 幻觉
@interface GPUImageCustomGlitchFilter : GPUImageFilter
{
    GLint timeUniform;
}

@property (nonatomic, assign) CGFloat time;

@end

NS_ASSUME_NONNULL_END
