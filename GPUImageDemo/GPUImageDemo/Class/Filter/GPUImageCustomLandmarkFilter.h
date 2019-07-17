//
//  GPUImageCustomLandmarkFilter.h
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/16.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import <GPUImage/GPUImage.h>

NS_ASSUME_NONNULL_BEGIN

@interface GPUImageCustomLandmarkFilter : GPUImageFilterGroup {
    GPUImageAlphaBlendFilter *alphaBlendFilter;
    GPUImageCrosshairGenerator *crosshairGenerator;
}

// Rendering
- (void)renderCrosshairsFromArray:(GLfloat *)crosshairCoordinates count:(NSUInteger)numberOfCrosshairs;

@end

NS_ASSUME_NONNULL_END
