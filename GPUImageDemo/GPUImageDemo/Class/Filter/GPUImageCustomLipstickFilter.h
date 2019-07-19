//
//  GPUImageCustomLipstickFilter.h
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/19.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import <GPUImage/GPUImage.h>

NS_ASSUME_NONNULL_BEGIN

@class GPUImageCustomLipstickGenerator;

@interface GPUImageCustomLipstickFilter : GPUImageFilterGroup
{
    GPUImageAlphaBlendFilter *alphaBlendFilter;
    GPUImageCustomLipstickGenerator *lipstickGenerator;
}

@property (nonatomic, assign) CGFloat texelWidthOffset;
@property (nonatomic, assign) CGFloat texelHeightOffset;

- (void)setColorRed:(GLfloat)redComponent green:(GLfloat)greenComponent blue:(GLfloat)blueComponent;
// Rendering
- (void)renderPointsFromArray:(GLfloat *)points count:(NSUInteger)numberOfPoints;

@end

NS_ASSUME_NONNULL_END
