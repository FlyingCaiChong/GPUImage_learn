//
//  ShowBlendViewController+AdjustFilter.m
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/11.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import "ShowBlendViewController+AdjustFilter.h"
#import "ShowBlendViewController+Private.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
#pragma clang diagnostic ignored "-Wundeclared-selector"
@implementation ShowBlendViewController (AdjustFilter)

- (void)configThresholdSensitivity:(CGFloat)thresholdSensitivity {
    GPUImageChromaKeyBlendFilter *filter = (GPUImageChromaKeyBlendFilter *)self.blendImageFilter;
    filter.thresholdSensitivity = thresholdSensitivity;
}

- (void)configSmoothing:(CGFloat)smoothing {
    GPUImageChromaKeyBlendFilter *filter = (GPUImageChromaKeyBlendFilter *)self.blendImageFilter;
    filter.smoothing = smoothing;
}

- (void)configDissolveMix:(CGFloat)mix {
    GPUImageDissolveBlendFilter *filter = (GPUImageDissolveBlendFilter *)self.blendImageFilter;
    filter.mix = mix;
}

- (void)configAlphaMix:(CGFloat)mix {
    GPUImageAlphaBlendFilter *filter = (GPUImageAlphaBlendFilter *)self.blendImageFilter;
    filter.mix = mix;
}

- (void)configPoissonMix:(CGFloat)mix {
    GPUImagePoissonBlendFilter *filter = (GPUImagePoissonBlendFilter *)self.blendImageFilter;
    filter.mix = mix;
}

- (void)configPoissonNumIterations:(NSUInteger)numIterations {
    GPUImagePoissonBlendFilter *filter = (GPUImagePoissonBlendFilter *)self.blendImageFilter;
    filter.numIterations = numIterations;
}

@end
#pragma clang diagnostic pop
