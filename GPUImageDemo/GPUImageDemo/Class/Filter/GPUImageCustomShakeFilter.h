//
//  GPUImageCustomShakeFilter.h
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/12.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import "GPUImageFilter.h"

NS_ASSUME_NONNULL_BEGIN
// 抖动
@interface GPUImageCustomShakeFilter : GPUImageFilter
{
    GLint timeUniform;
}

@property (nonatomic, assign) CGFloat time;
@end

NS_ASSUME_NONNULL_END
