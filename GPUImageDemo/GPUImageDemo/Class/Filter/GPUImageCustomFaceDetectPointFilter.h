//
//  GPUImageCustomFaceDetectPointFilter.h
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/25.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import "GPUImageFilter.h"

NS_ASSUME_NONNULL_BEGIN

@interface GPUImageCustomFaceDetectPointFilter : GPUImageFilter

/** 人脸检测点显示 默认开启*/
@property (nonatomic, assign) BOOL isShowFaceDetectPointBool;

- (void)setFacePointsArray:(NSArray *)pointArrays;

@end

NS_ASSUME_NONNULL_END
