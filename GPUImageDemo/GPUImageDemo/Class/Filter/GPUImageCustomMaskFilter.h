//
//  GPUImageCustomMaskFilter.h
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/16.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import "GPUImageFilter.h"

NS_ASSUME_NONNULL_BEGIN

@interface GPUImageCustomMaskFilter : GPUImageFilter
{
    GLint maskUniform;
}
@property (nonatomic, assign) CGRect mask;

@end

NS_ASSUME_NONNULL_END
