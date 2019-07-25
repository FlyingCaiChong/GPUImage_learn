//
//  GPUImageCustomFaceChangeFilter.h
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/25.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import "GPUImageFilter.h"

NS_ASSUME_NONNULL_BEGIN

@interface GPUImageCustomFaceChangeFilter : GPUImageFilter
{
    GLint faceArrayUniform;
    GLint iResolutionUniform;
    GLint haveFaceUniform;
}

/** 是否检测到人脸 */
@property (nonatomic, assign) BOOL isHaveFace;

/** 瘦脸调节 [-1.0，1.0] */
@property (nonatomic, assign) CGFloat thinFaceParam;

/** 眼睛调节 [-1.0，1.0] */
@property (nonatomic, assign) CGFloat eyeParam;

/** 鼻子调节 [-1.0, 1.0] */
@property (nonatomic, assign) CGFloat noseParam;

- (void)setFacePointArray:(NSArray *)pointArray width:(CGFloat)width height:(CGFloat)height;




@end

NS_ASSUME_NONNULL_END
