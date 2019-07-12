//
//  ShowViewController+AdjustFilter.m
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/10.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import "FHShowViewController+AdjustFilter.h"
#import "FHShowViewController+Private.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
#pragma clang diagnostic ignored "-Wundeclared-selector"

@implementation FHShowViewController (AdjustFilter)

- (void)configBrightness:(CGFloat)brightness {
    GPUImageBrightnessFilter *filter = (GPUImageBrightnessFilter *)self.imageFilter;
    filter.brightness = brightness;
}

- (void)configExposure:(CGFloat)exposure {
    GPUImageExposureFilter *filter = (GPUImageExposureFilter *)self.imageFilter;
    filter.exposure = exposure;
}

- (void)configContrast:(CGFloat)contrast {
    GPUImageContrastFilter *filter = (GPUImageContrastFilter *)self.imageFilter;
    filter.contrast = contrast;
}

- (void)configSaturation:(CGFloat)saturation {
    GPUImageSaturationFilter *filter = (GPUImageSaturationFilter *)self.imageFilter;
    filter.saturation = saturation;
}

- (void)configGamma:(CGFloat)gamma {
    GPUImageGammaFilter *filter = (GPUImageGammaFilter *)self.imageFilter;
    filter.gamma = gamma;
}

- (void)configHue:(CGFloat)hue {
    GPUImageHueFilter *filter = (GPUImageHueFilter *)self.imageFilter;
    filter.hue = hue;
}

- (void)configOpacity:(CGFloat)opacity {
    GPUImageOpacityFilter *filter = (GPUImageOpacityFilter *)self.imageFilter;
    filter.opacity = opacity;
}

- (void)configThreshold:(CGFloat)threshold {
    GPUImageLuminanceThresholdFilter *filter = (GPUImageLuminanceThresholdFilter *)self.imageFilter;
    filter.threshold = threshold;
}

- (void)configGlitchTime:(CGFloat)time {
    GPUImageCustomGlitchFilter *filter = (GPUImageCustomGlitchFilter *)self.imageFilter;
    filter.time = time;
}

- (void)configScaleTime:(CGFloat)time {
    GPUImageCustomScaleFilter *filter = (GPUImageCustomScaleFilter *)self.imageFilter;
    filter.time = time;
}

@end

#pragma clang diagnostic pop
