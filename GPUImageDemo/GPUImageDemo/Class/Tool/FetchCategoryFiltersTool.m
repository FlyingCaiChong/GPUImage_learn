//
//  FetchCategoryFiltersTool.m
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/9.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import "FetchCategoryFiltersTool.h"
/**
 input: 继承自 0:GPUImageFilterGroup 1:GPUImageFilter 2:GPUImageTwoInputFilter
 */
@implementation FetchCategoryFiltersTool

+ (NSArray *)colorAdjustmentsFilters {
    return @[
             @{
                 @"title": @"GPUImageBrightnessFilter",
                 @"desc": @"Adjusts the brightness of the image",
                 @"inherit": @"GPUImageFilter",
                 },
             @{
                 @"title": @"GPUImageExposureFilter",
                 @"desc": @"Adjusts the exposure of the image",
                 @"inherit": @"GPUImageFilter",
                 },
             @{
                 @"title": @"GPUImageContrastFilter",
                 @"desc": @"Adjusts the contrast of the image",
                 @"inherit": @"GPUImageFilter",
                 },
             @{
                 @"title": @"GPUImageSaturationFilter",
                 @"desc": @"Adjusts the saturation of an image",
                 @"inherit": @"GPUImageFilter",
                 },
             @{
                 @"title": @"GPUImageGammaFilter",
                 @"desc": @"Adjusts the gamma of an image",
                 @"inherit": @"GPUImageFilter",
                 },
             @{
                 @"title": @"GPUImageLevelsFilter",
                 @"desc": @"Photoshop-like levels adjustment. The min, max, minOut and maxOut parameters are floats in the range [0, 1]. If you have parameters from Photoshop in the range [0, 255] you must first convert them to be [0, 1]. The gamma/mid parameter is a float >= 0. This matches the value from Photoshop. If you want to apply levels to RGB as well as individual channels you need to use this filter twice - first for the individual channels and then for all channels.",
                 @"inherit": @"GPUImageFilter",
                 },
             @{
                 @"title": @"GPUImageColorMatrixFilter",
                 @"desc": @"Transforms the colors of an image by applying a matrix to them",
                 @"inherit": @"GPUImageFilter",
                 },
             @{
                 @"title": @"GPUImageRGBFilter",
                 @"desc": @"Adjusts the individual RGB channels of an image",
                 @"inherit": @"GPUImageFilter",
                 },
             @{
                 @"title": @"GPUImageHueFilter",
                 @"desc": @"Adjusts the hue of an image",
                 @"inherit": @"GPUImageFilter",
                 },
//             @{
//                 @"title": @"GPUImageVibranceFilter", // Deprecated
//                 @"desc": @"Adjusts the vibrance of an image",
//                 @"inherit": @"GPUImageFilter",
//                 },
             @{
                 @"title": @"GPUImageWhiteBalanceFilter",
                 @"desc": @"Adjusts the white balance of an image.",
                 @"inherit": @"GPUImageFilter",
                 },
             @{
                 @"title": @"GPUImageToneCurveFilter",
                 @"desc": @"Adjusts the colors of an image based on spline curves for each color channel.",
                 @"inherit": @"GPUImageFilter",
                 },
             @{
                 @"title": @"GPUImageHighlightShadowFilter",
                 @"desc": @"Adjusts the shadows and highlights of an image",
                 @"inherit": @"GPUImageFilter",
                 },
//             @{
//                 @"title": @"GPUImageHighlightShadowTintFilter", // Deprecated
//                 @"desc": @"Allows you to tint the shadows and highlights of an image independently using a color and intensity",
//                 @"inherit": @"GPUImageFilter",
//                 },
             @{
                 @"title": @"GPUImageLookupFilter",
                 @"desc": @"Uses an RGB color lookup image to remap the colors in an image. First, use your favourite photo editing application to apply a filter to lookup.png from GPUImage/framework/Resources. For this to work properly each pixel color must not depend on other pixels (e.g. blur will not work). If you need a more complex filter you can create as many lookup tables as required. Once ready, use your new lookup.png file as a second input for GPUImageLookupFilter.",
                 @"inherit": @"GPUImageTwoInputFilter",
                 },
             @{
                 @"title": @"GPUImageAmatorkaFilter",
                 @"desc": @"A photo filter based on a Photoshop action by Amatorka: http://amatorka.deviantart.com/art/Amatorka-Action-2-121069631 . If you want to use this effect you have to add lookup_amatorka.png from the GPUImage Resources folder to your application bundle.",
                 @"inherit": @"GPUImageFilterGroup",
                 },
             @{
                 @"title": @"GPUImageMissEtikateFilter",
                 @"desc": @"A photo filter based on a Photoshop action by Miss Etikate: http://miss-etikate.deviantart.com/art/Photoshop-Action-15-120151961 . If you want to use this effect you have to add lookup_miss_etikate.png from the GPUImage Resources folder to your application bundle.",
                 @"inherit": @"GPUImageFilterGroup",
                 },
             @{
                 @"title": @"GPUImageSoftEleganceFilter",
                 @"desc": @"Another lookup-based color remapping filter. If you want to use this effect you have to add lookup_soft_elegance_1.png and lookup_soft_elegance_2.png from the GPUImage Resources folder to your application bundle.",
                 @"inherit": @"GPUImageFilterGroup",
                 },
//             @{
//                 @"title": @"GPUImageSkinToneFilter", // Deprecated
//                 @"desc": @"A skin-tone adjustment filter that affects a unique range of light skin-tone colors and adjusts the pink/green or pink/orange range accordingly. Default values are targetted at fair caucasian skin, but can be adjusted as required.",
//                 @"inherit": @"GPUImageFilter",
//                 },
             @{
                 @"title": @"GPUImageColorInvertFilter",
                 @"desc": @"Inverts the colors of an image",
                 @"inherit": @"GPUImageFilter",
                 },
             @{
                 @"title": @"GPUImageGrayscaleFilter",
                 @"desc": @"Converts an image to grayscale (a slightly faster implementation of the saturation filter, without the ability to vary the color contribution)",
                 @"inherit": @"GPUImageFilter",
                 },
             @{
                 @"title": @"GPUImageMonochromeFilter",
                 @"desc": @"Converts the image to a single-color version, based on the luminance of each pixel",
                 @"inherit": @"GPUImageFilter",
                 },
             @{
                 @"title": @"GPUImageFalseColorFilter",
                 @"desc": @"Uses the luminance of the image to mix between two user-specified colors",
                 @"inherit": @"GPUImageFilter",
                 },
             @{
                 @"title": @"GPUImageHazeFilter",
                 @"desc": @"Used to add or remove haze (similar to a UV filter)",
                 @"inherit": @"GPUImageFilter",
                 },
             @{
                 @"title": @"GPUImageSepiaFilter",
                 @"desc": @"Simple sepia tone filter",
                 @"inherit": @"GPUImageColorMatrixFilter",
                 },
             @{
                 @"title": @"GPUImageOpacityFilter",
                 @"desc": @"Adjusts the alpha channel of the incoming image",
                 @"inherit": @"GPUImageFilter",
                 },
             @{
                 @"title": @"GPUImageSolidColorGenerator",
                 @"desc": @"This outputs a generated image with a solid color. You need to define the image size using -forceProcessingAtSize",
                 @"inherit": @"GPUImageFilter",
                 },
             @{
                 @"title": @"GPUImageLuminanceThresholdFilter",
                 @"desc": @"Pixels with a luminance above the threshold will appear white, and those below will be black",
                 @"inherit": @"GPUImageFilter",
                 },
             @{
                 @"title": @"GPUImageAdaptiveThresholdFilter",
                 @"desc": @"Determines the local luminance around a pixel, then turns the pixel black if it is below that local luminance and white if above. This can be useful for picking out text under varying lighting conditions.",
                 @"inherit": @"GPUImageFilterGroup",
                 },
             @{
                 @"title": @"GPUImageAverageLuminanceThresholdFilter",
                 @"desc": @"This applies a thresholding operation where the threshold is continually adjusted based on the average luminance of the scene",
                 @"inherit": @"GPUImageFilterGroup",
                 },
             @{
                 @"title": @"GPUImageHistogramFilter",
                 @"desc": @"This analyzes the incoming image and creates an output histogram with the frequency at which each color value occurs. The output of this filter is a 3-pixel-high, 256-pixel-wide image with the center (vertical) pixels containing pixels that correspond to the frequency at which various color values occurred. Each color value occupies one of the 256 width positions, from 0 on the left to 255 on the right. This histogram can be generated for individual color channels (kGPUImageHistogramRed, kGPUImageHistogramGreen, kGPUImageHistogramBlue), the luminance of the image (kGPUImageHistogramLuminance), or for all three color channels at once (kGPUImageHistogramRGB).",
                 @"inherit": @"GPUImageFilter",
                 },
             @{
                 @"title": @"GPUImageHistogramGenerator",
                 @"desc": @" This is a special filter, in that it's primarily intended to work with the GPUImageHistogramFilter. It generates an output representation of the color histograms generated by GPUImageHistogramFilter, but it could be repurposed to display other kinds of values. It takes in an image and looks at the center (vertical) pixels. It then plots the numerical values of the RGB components in separate colored graphs in an output texture. You may need to force a size for this filter in order to make its output visible.",
                 @"inherit": @"GPUImageFilter",
                 },
             @{
                 @"title": @"GPUImageAverageColor",
                 @"desc": @"This processes an input image and determines the average color of the scene, by averaging the RGBA components for each pixel in the image. A reduction process is used to progressively downsample the source image on the GPU, followed by a short averaging calculation on the CPU. The output from this filter is meaningless, but you need to set the colorAverageProcessingFinishedBlock property to a block that takes in four color components and a frame time and does something with them.",
                 @"inherit": @"GPUImageFilter",
                 },
             @{
                 @"title": @"GPUImageLuminosity",
                 @"desc": @"Like the GPUImageAverageColor, this reduces an image to its average luminosity. You need to set the luminosityProcessingFinishedBlock to handle the output of this filter, which just returns a luminosity value and a frame time.",
                 @"inherit": @"GPUImageAverageColor",
                 },
             @{
                 @"title": @"GPUImageChromaKeyFilter",
                 @"desc": @"For a given color in the image, sets the alpha channel to 0. This is similar to the GPUImageChromaKeyBlendFilter, only instead of blending in a second image for a matching color this doesn't take in a second image and just turns a given color transparent.",
                 @"inherit": @"GPUImageFilter",
                 },
             ];
}

+ (NSArray *)imageProcessingFilters {
    return @[
             @{
                 @"title": @"GPUImageTransformFilter",
                 @"desc": @"This applies an arbitrary 2-D or 3-D transformation to an image",
                 @"inherit": @"GPUImageFilter",
                 },
             @{
                 @"title": @"GPUImageCropFilter",
                 @"desc": @"This crops an image to a specific region, then passes only that region on to the next stage in the filter",
                 @"inherit": @"GPUImageFilter",
                 },
             @{
                 @"title": @"GPUImageLanczosResamplingFilter",
                 @"desc": @"This lets you up- or downsample an image using Lanczos resampling, which results in noticeably better quality than the standard linear or trilinear interpolation. Simply use -forceProcessingAtSize: to set the target output resolution for the filter, and the image will be resampled for that new size.",
                 @"inherit": @"GPUImageTwoPassTextureSamplingFilter",
                 },
             @{
                 @"title": @"GPUImageSharpenFilter",
                 @"desc": @"Sharpens the image",
                 @"inherit": @"GPUImageFilter",
                 },
             @{
                 @"title": @"GPUImageUnsharpMaskFilter",
                 @"desc": @"Applies an unsharp mask",
                 @"inherit": @"GPUImageFilterGroup",
                 },
             @{
                 @"title": @"GPUImageGaussianBlurFilter",
                 @"desc": @"A hardware-optimized, variable-radius Gaussian blur",
                 @"inherit": @"GPUImageTwoPassTextureSamplingFilter",
                 },
             @{
                 @"title": @"GPUImageBoxBlurFilter",
                 @"desc": @"A hardware-optimized, variable-radius box blur",
                 @"inherit": @"GPUImageGaussianBlurFilter",
                 },
             @{
                 @"title": @"GPUImageSingleComponentGaussianBlurFilter",
                 @"desc": @" A modification of the GPUImageGaussianBlurFilter that operates only on the red component",
                 @"inherit": @"GPUImageGaussianBlurFilter",
                 },
             @{
                 @"title": @"GPUImageGaussianSelectiveBlurFilter",
                 @"desc": @" A Gaussian blur that preserves focus within a circular region",
                 @"inherit": @"GPUImageFilterGroup",
                 },
             @{
                 @"title": @"GPUImageGaussianBlurPositionFilter",
                 @"desc": @"The inverse of the GPUImageGaussianSelectiveBlurFilter, applying the blur only within a certain circle",
                 @"inherit": @"GPUImageTwoPassTextureSamplingFilter",
                 },
             @{
                 @"title": @"GPUImageiOSBlurFilter",
                 @"desc": @"An attempt to replicate the background blur used on iOS 7 in places like the control center.",
                 @"inherit": @"GPUImageFilterGroup",
                 },
             @{
                 @"title": @"GPUImageMedianFilter",
                 @"desc": @"Takes the median value of the three color components, over a 3x3 area",
                 @"inherit": @"GPUImage3x3TextureSamplingFilter",
                 },
             @{
                 @"title": @"GPUImageBilateralFilter",
                 @"desc": @"A bilateral blur, which tries to blur similar color values while preserving sharp edges",
                 @"inherit": @"GPUImageGaussianBlurFilter",
                 },
             @{
                 @"title": @"GPUImageTiltShiftFilter",
                 @"desc": @"A simulated tilt shift lens effect",
                 @"inherit": @"GPUImageFilterGroup",
                 },
             @{
                 @"title": @"GPUImage3x3ConvolutionFilter",
                 @"desc": @"Runs a 3x3 convolution kernel against the image",
                 @"inherit": @"GPUImage3x3TextureSamplingFilter",
                 },
             @{
                 @"title": @"GPUImageSobelEdgeDetectionFilter",
                 @"desc": @"Sobel edge detection, with edges highlighted in white",
                 @"inherit": @"GPUImageTwoPassFilter",
                 },
             @{
                 @"title": @"GPUImagePrewittEdgeDetectionFilter",
                 @"desc": @"Prewitt edge detection, with edges highlighted in white",
                 @"inherit": @"GPUImageSobelEdgeDetectionFilter",
                 },
             @{
                 @"title": @"GPUImageThresholdEdgeDetectionFilter",
                 @"desc": @"Performs Sobel edge detection, but applies a threshold instead of giving gradual strength values",
                 @"inherit": @"GPUImageSobelEdgeDetectionFilter",
                 },
             @{
                 @"title": @"GPUImageCannyEdgeDetectionFilter",
                 @"desc": @"This uses the full Canny process to highlight one-pixel-wide edges",
                 @"inherit": @"GPUImageFilterGroup",
                 },
             @{
                 @"title": @"GPUImageHarrisCornerDetectionFilter",
                 @"desc": @"Runs the Harris corner detection algorithm on an input image, and produces an image with those corner points as white pixels and everything else black. The cornersDetectedBlock can be set, and you will be provided with a list of corners (in normalized 0..1 X, Y coordinates) within that callback for whatever additional operations you want to perform.",
                 @"inherit": @"GPUImageFilterGroup",
                 },
             @{
                 @"title": @"GPUImageNobleCornerDetectionFilter",
                 @"desc": @"Runs the Noble variant on the Harris corner detector. It behaves as described above for the Harris detector.",
                 @"inherit": @"GPUImageHarrisCornerDetectionFilter",
                 },
//             @{
//                 @"title": @"GPUImageShiTomasiCornerDetectionFilter", // Deprecated
//                 @"desc": @"Runs the Shi-Tomasi feature detector. It behaves as described above for the Harris detector.",
//                 @"inherit": @"GPUImageFilter",
//                 },
             @{
                 @"title": @"GPUImageNonMaximumSuppressionFilter",
                 @"desc": @"Currently used only as part of the Harris corner detection filter, this will sample a 1-pixel box around each pixel and determine if the center pixel's red channel is the maximum in that area. If it is, it stays. If not, it is set to 0 for all color components.",
                 @"inherit": @"GPUImage3x3TextureSamplingFilter",
                 },
             @{
                 @"title": @"GPUImageXYDerivativeFilter",
                 @"desc": @"An internal component within the Harris corner detection filter, this calculates the squared difference between the pixels to the left and right of this one, the squared difference of the pixels above and below this one, and the product of those two differences.",
                 @"inherit": @"GPUImageSobelEdgeDetectionFilter",
                 },
             @{
                 @"title": @"GPUImageCrosshairGenerator",
                 @"desc": @"This draws a series of crosshairs on an image, most often used for identifying machine vision features. It does not take in a standard image like other filters, but a series of points in its -renderCrosshairsFromArray:count: method, which does the actual drawing. You will need to force this filter to render at the particular output size you need.",
                 @"inherit": @"GPUImageFilter",
                 },
             @{
                 @"title": @"GPUImageDilationFilter",
                 @"desc": @"This performs an image dilation operation, where the maximum intensity of the red channel in a rectangular neighborhood is used for the intensity of this pixel. The radius of the rectangular area to sample over is specified on initialization, with a range of 1-4 pixels. This is intended for use with grayscale images, and it expands bright regions.",
                 @"inherit": @"GPUImageTwoPassTextureSamplingFilter",
                 },
             @{
                 @"title": @"GPUImageRGBDilationFilter",
                 @"desc": @"This is the same as the GPUImageDilationFilter, except that this acts on all color channels, not just the red channel.",
                 @"inherit": @"GPUImageTwoPassTextureSamplingFilter",
                 },
             @{
                 @"title": @"GPUImageErosionFilter",
                 @"desc": @"This performs an image erosion operation, where the minimum intensity of the red channel in a rectangular neighborhood is used for the intensity of this pixel. The radius of the rectangular area to sample over is specified on initialization, with a range of 1-4 pixels. This is intended for use with grayscale images, and it expands dark regions.",
                 @"inherit": @"GPUImageTwoPassTextureSamplingFilter",
                 },
             @{
                 @"title": @"GPUImageRGBErosionFilter",
                 @"desc": @"This is the same as the GPUImageErosionFilter, except that this acts on all color channels, not just the red channel.",
                 @"inherit": @"GPUImageTwoPassTextureSamplingFilter",
                 },
             @{
                 @"title": @"GPUImageOpeningFilter",
                 @"desc": @"This performs an erosion on the red channel of an image, followed by a dilation of the same radius. The radius is set on initialization, with a range of 1-4 pixels. This filters out smaller bright regions.",
                 @"inherit": @"GPUImageFilterGroup",
                 },
             @{
                 @"title": @"GPUImageRGBOpeningFilter",
                 @"desc": @"This is the same as the GPUImageOpeningFilter, except that this acts on all color channels, not just the red channel.",
                 @"inherit": @"GPUImageFilterGroup",
                 },
             @{
                 @"title": @"GPUImageClosingFilter",
                 @"desc": @"This performs a dilation on the red channel of an image, followed by an erosion of the same radius. The radius is set on initialization, with a range of 1-4 pixels. This filters out smaller dark regions.",
                 @"inherit": @"GPUImageFilterGroup",
                 },
             @{
                 @"title": @"GPUImageRGBClosingFilter",
                 @"desc": @"This is the same as the GPUImageClosingFilter, except that this acts on all color channels, not just the red channel.",
                 @"inherit": @"GPUImageFilterGroup",
                 },
             @{
                 @"title": @"GPUImageLocalBinaryPatternFilter",
                 @"desc": @"This performs a comparison of intensity of the red channel of the 8 surrounding pixels and that of the central one, encoding the comparison results in a bit string that becomes this pixel intensity. The least-significant bit is the top-right comparison, going counterclockwise to end at the right comparison as the most significant bit.",
                 @"inherit": @"GPUImage3x3TextureSamplingFilter",
                 },
             @{
                 @"title": @"GPUImageLowPassFilter",
                 @"desc": @"This applies a low pass filter to incoming video frames. This basically accumulates a weighted rolling average of previous frames with the current ones as they come in. This can be used to denoise video, add motion blur, or be used to create a high pass filter.",
                 @"inherit": @"GPUImageFilterGroup",
                 },
             @{
                 @"title": @"GPUImageHighPassFilter",
                 @"desc": @"This applies a high pass filter to incoming video frames. This is the inverse of the low pass filter, showing the difference between the current frame and the weighted rolling average of previous ones. This is most useful for motion detection.",
                 @"inherit": @"GPUImageFilterGroup",
                 },
             @{
                 @"title": @"GPUImageMotionDetector",
                 @"desc": @"This is a motion detector based on a high-pass filter. You set the motionDetectionBlock and on every incoming frame it will give you the centroid of any detected movement in the scene (in normalized X,Y coordinates) as well as an intensity of motion for the scene.",
                 @"inherit": @"GPUImageFilterGroup",
                 },
             @{
                 @"title": @"GPUImageHoughTransformLineDetector",
                 @"desc": @"Detects lines in the image using a Hough transform into parallel coordinate space. This approach is based entirely on the PC lines process developed by the Graph@FIT research group at the Brno University of Technology and described in their publications: M. Dubská, J. Havel, and A. Herout. Real-Time Detection of Lines using Parallel Coordinates and OpenGL. Proceedings of SCCG 2011, Bratislava, SK, p. 7 (http://medusa.fit.vutbr.cz/public/data/papers/2011-SCCG-Dubska-Real-Time-Line-Detection-Using-PC-and-OpenGL.pdf) and M. Dubská, J. Havel, and A. Herout. PClines — Line detection using parallel coordinates. 2011 IEEE Conference on Computer Vision and Pattern Recognition (CVPR), p. 1489- 1494 (http://medusa.fit.vutbr.cz/public/data/papers/2011-CVPR-Dubska-PClines.pdf).",
                 @"inherit": @"GPUImageFilterGroup",
                 },
             @{
                 @"title": @"GPUImageLineGenerator",
                 @"desc": @"A helper class that generates lines which can overlay the scene. The color of these lines can be adjusted using -setLineColorRed:green:blue:",
                 @"inherit": @"GPUImageFilter",
                 },
             @{
                 @"title": @"GPUImageMotionBlurFilter",
                 @"desc": @"Applies a directional motion blur to an image",
                 @"inherit": @"GPUImageFilter",
                 },
             @{
                 @"title": @"GPUImageZoomBlurFilter",
                 @"desc": @"Applies a directional motion blur to an image",
                 @"inherit": @"GPUImageFilter",
                 },
             ];
}

+ (NSArray *)blendingModesFilters {
    return @[
             @{
                 @"title": @"GPUImageChromaKeyBlendFilter",
                 @"desc": @"Selectively replaces a color in the first image with the second image",
                 @"inherit": @"GPUImageTwoInputFilter",
                 },
             @{
                 @"title": @"GPUImageDissolveBlendFilter",
                 @"desc": @"Applies a dissolve blend of two images",
                 @"inherit": @"GPUImageTwoInputFilter",
                 },
             @{
                 @"title": @"GPUImageMultiplyBlendFilter",
                 @"desc": @"Applies a multiply blend of two images",
                 @"inherit": @"GPUImageTwoInputFilter",
                 },
             @{
                 @"title": @"GPUImageAddBlendFilter",
                 @"desc": @"Applies an additive blend of two images",
                 @"inherit": @"GPUImageTwoInputFilter",
                 },
             @{
                 @"title": @"GPUImageSubtractBlendFilter",
                 @"desc": @"Applies a subtractive blend of two images",
                 @"inherit": @"GPUImageTwoInputFilter",
                 },
             @{
                 @"title": @"GPUImageDivideBlendFilter",
                 @"desc": @"Applies a division blend of two images",
                 @"inherit": @"GPUImageTwoInputFilter",
                 },
             @{
                 @"title": @"GPUImageOverlayBlendFilter",
                 @"desc": @"Applies an overlay blend of two images",
                 @"inherit": @"GPUImageTwoInputFilter",
                 },
             @{
                 @"title": @"GPUImageDarkenBlendFilter",
                 @"desc": @"Blends two images by taking the minimum value of each color component between the images",
                 @"inherit": @"GPUImageTwoInputFilter",
                 },
             @{
                 @"title": @"GPUImageLightenBlendFilter",
                 @"desc": @"Blends two images by taking the maximum value of each color component between the images",
                 @"inherit": @"GPUImageTwoInputFilter",
                 },
             @{
                 @"title": @"GPUImageColorBurnBlendFilter",
                 @"desc": @"Applies a color burn blend of two images",
                 @"inherit": @"GPUImageTwoInputFilter",
                 },
             @{
                 @"title": @"GPUImageColorDodgeBlendFilter",
                 @"desc": @"Applies a color dodge blend of two images",
                 @"inherit": @"GPUImageTwoInputFilter",
                 },
             @{
                 @"title": @"GPUImageScreenBlendFilter",
                 @"desc": @"Applies a screen blend of two images",
                 @"inherit": @"GPUImageTwoInputFilter",
                 },
             @{
                 @"title": @"GPUImageExclusionBlendFilter",
                 @"desc": @"Applies an exclusion blend of two images",
                 @"inherit": @"GPUImageTwoInputFilter",
                 },
             @{
                 @"title": @"GPUImageDifferenceBlendFilter",
                 @"desc": @"Applies a difference blend of two images",
                 @"inherit": @"GPUImageTwoInputFilter",
                 },
             @{
                 @"title": @"GPUImageHardLightBlendFilter",
                 @"desc": @"Applies a hard light blend of two images",
                 @"inherit": @"GPUImageTwoInputFilter",
                 },
             @{
                 @"title": @"GPUImageSoftLightBlendFilter",
                 @"desc": @"Applies a soft light blend of two images",
                 @"inherit": @"GPUImageTwoInputFilter",
                 },
             @{
                 @"title": @"GPUImageAlphaBlendFilter",
                 @"desc": @"Blends the second image over the first, based on the second's alpha channel",
                 @"inherit": @"GPUImageTwoInputFilter",
                 },
             @{
                 @"title": @"GPUImageSourceOverBlendFilter",
                 @"desc": @"Applies a source over blend of two images",
                 @"inherit": @"GPUImageTwoInputFilter",
                 },
             @{
                 @"title": @"GPUImageColorBurnBlendFilter",
                 @"desc": @"Applies a color burn blend of two images",
                 @"inherit": @"GPUImageTwoInputFilter",
                 },
             @{
                 @"title": @"GPUImageColorDodgeBlendFilter",
                 @"desc": @"Applies a color dodge blend of two images",
                 @"inherit": @"GPUImageTwoInputFilter",
                 },
             @{
                 @"title": @"GPUImageNormalBlendFilter",
                 @"desc": @"Applies a normal blend of two images",
                 @"inherit": @"GPUImageTwoInputFilter",
                 },
             @{
                 @"title": @"GPUImageColorBlendFilter",
                 @"desc": @"Applies a color blend of two images",
                 @"inherit": @"GPUImageTwoInputFilter",
                 },
             @{
                 @"title": @"GPUImageHueBlendFilter",
                 @"desc": @"Applies a hue blend of two images",
                 @"inherit": @"GPUImageTwoInputFilter",
                 },
             @{
                 @"title": @"GPUImageSaturationBlendFilter",
                 @"desc": @"Applies a saturation blend of two images",
                 @"inherit": @"GPUImageTwoInputFilter",
                 },
             @{
                 @"title": @"GPUImageLuminosityBlendFilter",
                 @"desc": @"Applies a luminosity blend of two images",
                 @"inherit": @"GPUImageTwoInputFilter",
                 },
             @{
                 @"title": @"GPUImageLinearBurnBlendFilter",
                 @"desc": @"Applies a linear burn blend of two images",
                 @"inherit": @"GPUImageTwoInputFilter",
                 },
             @{
                 @"title": @"GPUImagePoissonBlendFilter",
                 @"desc": @"Applies a Poisson blend of two images",
                 @"inherit": @"GPUImageTwoInputCrossTextureSamplingFilter",
                 },
             @{
                 @"title": @"GPUImageMaskFilter",
                 @"desc": @"Masks one image using another",
                 @"inherit": @"GPUImageTwoInputFilter",
                 },
             ];
}

+ (NSArray *)visualEffectsFilters {
    return @[
             @{
                 @"title": @"GPUImagePixellateFilter",
                 @"desc": @"Applies a pixellation effect on an image or video",
                 @"inherit": @"GPUImageFilter",
                 },
             @{
                 @"title": @"GPUImagePolarPixellateFilter",
                 @"desc": @"Applies a pixellation effect on an image or video, based on polar coordinates instead of Cartesian ones",
                 @"inherit": @"GPUImageFilter",
                 },
             @{
                 @"title": @"GPUImagePolkaDotFilter",
                 @"desc": @"Breaks an image up into colored dots within a regular grid",
                 @"inherit": @"GPUImagePixellateFilter",
                 },
             @{
                 @"title": @"GPUImageHalftoneFilter",
                 @"desc": @"Applies a halftone effect to an image, like news print",
                 @"inherit": @"GPUImagePixellateFilter",
                 },
             @{
                 @"title": @"GPUImageCrosshatchFilter",
                 @"desc": @"This converts an image into a black-and-white crosshatch pattern",
                 @"inherit": @"GPUImageFilter",
                 },
             @{
                 @"title": @"GPUImageSketchFilter",
                 @"desc": @"Converts video to look like a sketch. This is just the Sobel edge detection filter with the colors inverted",
                 @"inherit": @"GPUImageSobelEdgeDetectionFilter",
                 },
             @{
                 @"title": @"GPUImageThresholdSketchFilter",
                 @"desc": @"Same as the sketch filter, only the edges are thresholded instead of being grayscale",
                 @"inherit": @"GPUImageThresholdEdgeDetectionFilter",
                 },
             @{
                 @"title": @"GPUImageToonFilter",
                 @"desc": @"This uses Sobel edge detection to place a black border around objects, and then it quantizes the colors present in the image to give a cartoon-like quality to the image.",
                 @"inherit": @"GPUImage3x3TextureSamplingFilter",
                 },
             @{
                 @"title": @"GPUImageSmoothToonFilter",
                 @"desc": @"This uses a similar process as the GPUImageToonFilter, only it precedes the toon effect with a Gaussian blur to smooth out noise.",
                 @"inherit": @"GPUImageFilterGroup",
                 },
             @{
                 @"title": @"GPUImageEmbossFilter",
                 @"desc": @"Applies an embossing effect on the image",
                 @"inherit": @"GPUImage3x3ConvolutionFilter",
                 },
             @{
                 @"title": @"GPUImagePosterizeFilter",
                 @"desc": @"This reduces the color dynamic range into the number of steps specified, leading to a cartoon-like simple shading of the image.",
                 @"inherit": @"GPUImageFilter",
                 },
             @{
                 @"title": @"GPUImageSwirlFilter",
                 @"desc": @"Creates a swirl distortion on the image",
                 @"inherit": @"GPUImageFilter",
                 },
             @{
                 @"title": @"GPUImageBulgeDistortionFilter",
                 @"desc": @"Creates a bulge distortion on the image",
                 @"inherit": @"GPUImageFilter",
                 },
             @{
                 @"title": @"GPUImagePinchDistortionFilter",
                 @"desc": @"Creates a pinch distortion of the image",
                 @"inherit": @"GPUImageFilter",
                 },
             @{
                 @"title": @"GPUImageStretchDistortionFilter",
                 @"desc": @"Creates a stretch distortion of the image",
                 @"inherit": @"GPUImageFilter",
                 },
             @{
                 @"title": @"GPUImageSphereRefractionFilter",
                 @"desc": @"Simulates the refraction through a glass sphere",
                 @"inherit": @"GPUImageFilter",
                 },
             @{
                 @"title": @"GPUImageGlassSphereFilter",
                 @"desc": @"Same as the GPUImageSphereRefractionFilter, only the image is not inverted and there's a little bit of frosting at the edges of the glass",
                 @"inherit": @"GPUImageSphereRefractionFilter",
                 },
             @{
                 @"title": @"GPUImageVignetteFilter",
                 @"desc": @"Performs a vignetting effect, fading out the image at the edges",
                 @"inherit": @"GPUImageFilter",
                 },
             @{
                 @"title": @"GPUImageKuwaharaFilter",
                 @"desc": @"Kuwahara image abstraction, drawn from the work of Kyprianidis, et. al. in their publication \"Anisotropic Kuwahara Filtering on the GPU\" within the GPU Pro collection. This produces an oil-painting-like image, but it is extremely computationally expensive, so it can take seconds to render a frame on an iPad 2. This might be best used for still images.",
                 @"inherit": @"GPUImageFilter",
                 },
             @{
                 @"title": @"GPUImageKuwaharaRadius3Filter",
                 @"desc": @"A modified version of the Kuwahara filter, optimized to work over just a radius of three pixels",
                 @"inherit": @"GPUImageFilter",
                 },
             @{
                 @"title": @"GPUImagePerlinNoiseFilter",
                 @"desc": @"Generates an image full of Perlin noise",
                 @"inherit": @"GPUImageFilter",
                 },
             @{
                 @"title": @"GPUImageCGAColorspaceFilter",
                 @"desc": @"Simulates the colorspace of a CGA monitor",
                 @"inherit": @"GPUImageFilter",
                 },
             @{
                 @"title": @"GPUImageMosaicFilter",
                 @"desc": @"This filter takes an input tileset, the tiles must ascend in luminance. It looks at the input image and replaces each display tile with an input tile according to the luminance of that tile. The idea was to replicate the ASCII video filters seen in other apps, but the tileset can be anything.",
                 @"inherit": @"GPUImageTwoInputFilter",
                 },
             @{
                 @"title": @"GPUImageJFAVoronoiFilter",
                 @"desc": @"Generates a Voronoi map, for use in a later stage.",
                 @"inherit": @"GPUImageFilter",
                 },
             @{
                 @"title": @"GPUImageVoronoiConsumerFilter",
                 @"desc": @"Takes in the Voronoi map, and uses that to filter an incoming image.",
                 @"inherit": @"GPUImageTwoInputFilter",
                 },
             ];
}

@end
