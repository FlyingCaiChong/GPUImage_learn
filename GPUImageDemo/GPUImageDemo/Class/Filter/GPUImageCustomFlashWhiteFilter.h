//
//  GPUImageCustomFlashWhiteFilter.h
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/12.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import "GPUImageFilter.h"

// @see: https://mp.weixin.qq.com/s/YWqejVy8q8qPzhDfljCHDw

NS_ASSUME_NONNULL_BEGIN

@interface GPUImageCustomFlashWhiteFilter : GPUImageFilter
{
    GLint timeUniform;
}

@property (nonatomic, assign) CGFloat time;

@end

NS_ASSUME_NONNULL_END
