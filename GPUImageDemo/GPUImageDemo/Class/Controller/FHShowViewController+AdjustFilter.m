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

- (void)configShakeTime:(CGFloat)time {
    GPUImageCustomShakeFilter *filter = (GPUImageCustomShakeFilter *)self.imageFilter;
    filter.time = time;
}

- (void)configFlashWhiteTime:(CGFloat)time {
    GPUImageCustomFlashWhiteFilter *filter = (GPUImageCustomFlashWhiteFilter *)self.imageFilter;
    filter.time = time;
}

- (void)configIllusionTime:(CGFloat)time {
    GPUImageCustomIllusionFilter *filter = (GPUImageCustomIllusionFilter *)self.imageFilter;
    filter.time = time;
}

- (void)configEyeParam:(CGFloat)eyeParam {
    GPUImageCustomFaceChangeFilter *filter = (GPUImageCustomFaceChangeFilter *)self.imageFilter;
    filter.eyeParam = eyeParam;
}

- (void)configFaceChangeGroupEyeParam:(CGFloat)eyeParam {
    GPUImageCustomFaceChangeGroup *filter = (GPUImageCustomFaceChangeGroup *)self.imageFilter;
    filter.eyeParam = eyeParam;
}

#pragma mark - Time Display
- (void)configTimeDisplay {
    
    if (![self needCreateTimer]) {
        return;
    }
    
    [self hiddenSlider];
    [self createTimer];
}

- (void)createTimer {
    if (self.displayLink) {
        [self.displayLink invalidate];
    }
    self.startTimeInterval = 0;
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(timeAction)];
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)timeAction {
    
    if (self.startTimeInterval == 0) {
        self.startTimeInterval = self.displayLink.timestamp;
    }
    
    CGFloat currentTime = self.displayLink.timestamp - self.startTimeInterval;
    
    if ([self.imageFilter isKindOfClass:[GPUImageCustomGlitchFilter class]]) {
        [self configGlitchTime:currentTime];
    }
    else if ([self.imageFilter isKindOfClass:[GPUImageCustomScaleFilter class]]) {
        [self configScaleTime:currentTime];
    }
    else if ([self.imageFilter isKindOfClass:[GPUImageCustomShakeFilter class]]) {
        [self configShakeTime:currentTime];
    }
    else if ([self.imageFilter isKindOfClass:[GPUImageCustomFlashWhiteFilter class]]) {
        [self configFlashWhiteTime:currentTime];
    }
    else if ([self.imageFilter isKindOfClass:[GPUImageCustomIllusionFilter class]]) {
        [self configIllusionTime:currentTime];
    }
}

- (BOOL)needCreateTimer {
    
    NSArray *arr = @[
                     NSStringFromClass([GPUImageCustomGlitchFilter class]),
                     NSStringFromClass([GPUImageCustomScaleFilter class]),
                     NSStringFromClass([GPUImageCustomShakeFilter class]),
                     NSStringFromClass([GPUImageCustomFlashWhiteFilter class]),
                     NSStringFromClass([GPUImageCustomIllusionFilter class]),
                     ];
    return [arr containsObject:self.item.title];
}

@end

#pragma clang diagnostic pop
