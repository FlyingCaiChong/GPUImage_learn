//
//  FetchCategoryFiltersTool.m
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/9.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import "FetchCategoryFiltersTool.h"

@implementation FetchCategoryFiltersTool

+ (NSArray *)colorAdjustmentsFilters {
    return @[
             @"GPUImageBrightnessFilter",
             @"GPUImageExposureFilter",
             @"GPUImageContrastFilter",
             @"GPUImageSaturationFilter",
             @"GPUImageGammaFilter",
             @"GPUImageLevelsFilter",
             @"GPUImageColorMatrixFilter",
             @"GPUImageRGBFilter",
             @"GPUImageHueFilter",
             @"GPUImageVibranceFilter",
             @"GPUImageWhiteBalanceFilter",
             @"GPUImageToneCurveFilter",
             @"GPUImageHighlightShadowFilter",
             @"GPUImageHighlightShadowTintFilter",
             @"GPUImageLookupFilter",
             @"GPUImageAmatorkaFilter",
             @"GPUImageMissEtikateFilter",
             @"GPUImageSoftEleganceFilter",
             @"GPUImageSkinToneFilter",
             @"GPUImageColorInvertFilter",
             @"GPUImageGrayscaleFilter",
             @"GPUImageMonochromeFilter",
             @"GPUImageFalseColorFilter",
             @"GPUImageHazeFilter",
             @"GPUImageSepiaFilter",
             @"GPUImageOpacityFilter",
             @"GPUImageSolidColorGenerator",
             @"GPUImageLuminanceThresholdFilter",
             @"GPUImageAdaptiveThresholdFilter",
             @"GPUImageAverageLuminanceThresholdFilter",
             @"GPUImageHistogramFilter",
             @"GPUImageHistogramGenerator",
             @"GPUImageAverageColor",
             @"GPUImageLuminosity",
             @"GPUImageChromaKeyFilter",
             ];
}

+ (NSArray *)imageProcessingFilters {
    return @[
             @"GPUImageTransformFilter",
             @"GPUImageCropFilter",
             @"GPUImageLanczosResamplingFilter",
             @"GPUImageSharpenFilter",
             @"GPUImageUnsharpMaskFilter",
             @"GPUImageGaussianBlurFilter",
             @"GPUImageBoxBlurFilter",
             @"GPUImageSingleComponentGaussianBlurFilter",
             @"GPUImageGaussianSelectiveBlurFilter",
             @"GPUImageGaussianBlurPositionFilter",
             @"GPUImageiOSBlurFilter",
             @"GPUImageMedianFilter",
             @"GPUImageBilateralFilter",
             @"GPUImageTiltShiftFilter",
             @"GPUImage3x3ConvolutionFilter",
             @"GPUImageSobelEdgeDetectionFilter",
             @"GPUImagePrewittEdgeDetectionFilter",
             @"GPUImageThresholdEdgeDetectionFilter",
             @"GPUImageCannyEdgeDetectionFilter",
             @"GPUImageHarrisCornerDetectionFilter",
             @"GPUImageNobleCornerDetectionFilter",
             @"GPUImageShiTomasiCornerDetectionFilter",
             @"GPUImageNonMaximumSuppressionFilter",
             @"GPUImageXYDerivativeFilter",
             @"GPUImageCrosshairGenerator",
             @"GPUImageDilationFilter",
             @"GPUImageRGBDilationFilter",
             @"GPUImageErosionFilter",
             @"GPUImageRGBErosionFilter",
             @"GPUImageOpeningFilter",
             @"GPUImageRGBOpeningFilter",
             @"GPUImageClosingFilter",
             @"GPUImageRGBClosingFilter",
             @"GPUImageLocalBinaryPatternFilter",
             @"GPUImageLowPassFilter",
             @"GPUImageHighPassFilter",
             @"GPUImageMotionDetector",
             @"GPUImageHoughTransformLineDetector",
             @"GPUImageLineGenerator",
             @"GPUImageMotionBlurFilter",
             @"GPUImageZoomBlurFilter",
             ];
}

+ (NSArray *)blendingModesFilters {
    return @[
             @"GPUImageChromaKeyBlendFilter",
             @"GPUImageDissolveBlendFilter",
             @"GPUImageMultiplyBlendFilter",
             @"GPUImageAddBlendFilter",
             @"GPUImageSubtractBlendFilter",
             @"GPUImageDivideBlendFilter",
             @"GPUImageOverlayBlendFilter",
             @"GPUImageDarkenBlendFilter",
             @"GPUImageLightenBlendFilter",
             @"GPUImageColorBurnBlendFilter",
             @"GPUImageColorDodgeBlendFilter",
             @"GPUImageScreenBlendFilter",
             @"GPUImageExclusionBlendFilter",
             @"GPUImageDifferenceBlendFilter",
             @"GPUImageHardLightBlendFilter",
             @"GPUImageSoftLightBlendFilter",
             @"GPUImageAlphaBlendFilter",
             @"GPUImageSourceOverBlendFilter",
             @"GPUImageColorBurnBlendFilter",
             @"GPUImageColorDodgeBlendFilter",
             @"GPUImageNormalBlendFilter",
             @"GPUImageColorBlendFilter",
             @"GPUImageHueBlendFilter",
             @"GPUImageSaturationBlendFilter",
             @"GPUImageLuminosityBlendFilter",
             @"GPUImageLinearBurnBlendFilter",
             @"GPUImagePoissonBlendFilter",
             @"GPUImageMaskFilter",
             ];
}

+ (NSArray *)visualEffectsFilters {
    return @[
             @"GPUImagePixellateFilter",
             @"GPUImagePolarPixellateFilter",
             @"GPUImagePolkaDotFilter",
             @"GPUImageHalftoneFilter",
             @"GPUImageCrosshatchFilter",
             @"GPUImageSketchFilter",
             @"GPUImageThresholdSketchFilter",
             @"GPUImageToonFilter",
             @"GPUImageSmoothToonFilter",
             @"GPUImageEmbossFilter",
             @"GPUImagePosterizeFilter",
             @"GPUImageSwirlFilter",
             @"GPUImageBulgeDistortionFilter",
             @"GPUImagePinchDistortionFilter",
             @"GPUImageStretchDistortionFilter",
             @"GPUImageSphereRefractionFilter",
             @"GPUImageGlassSphereFilter",
             @"GPUImageVignetteFilter",
             @"GPUImageKuwaharaFilter",
             @"GPUImageKuwaharaRadius3Filter",
             @"GPUImagePerlinNoiseFilter",
             @"GPUImageCGAColorspaceFilter",
             @"GPUImageMosaicFilter",
             @"GPUImageJFAVoronoiFilter",
             @"GPUImageVoronoiConsumerFilter",
             ];
}

@end
