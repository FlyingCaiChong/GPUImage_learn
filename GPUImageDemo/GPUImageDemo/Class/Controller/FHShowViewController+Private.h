//
//  ShowViewController+Private.h
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/10.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import "FHShowViewController.h"
#import "GPUImage.h"
#import "FHFilterListItem.h"
#import "GPUImageCustomGlitchFilter.h"
#import "GPUImageCustomScaleFilter.h"
#import "GPUImageCustomShakeFilter.h"
#import "GPUImageCustomFlashWhiteFilter.h"
#import "GPUImageCustomIllusionFilter.h"
#import "GPUImageCustomMaskFilter.h"
#import "GPUImageCustomFeaturePointsFilter.h"
#import "GPUImageCustomLandmarkFilter.h"
#import "GPUImageCustomAddPointsFilter.h"
#import "GPUImageCustomFaceChangeFilter.h"
#import "GPUImageCustomFaceChangeGroup.h"
#import "SXSenseDetectTool.h"
#import "UIImage+SXExtension.h"
#import "MGFaceLicenseHandle.h"
#import "MGFacepp.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ShowType) {
    ShowTypeImage,
    ShowTypeCamera,
};

@interface FHShowViewController ()<GPUImageVideoCameraDelegate>

// face++的sdk是否授权可用
@property (nonatomic, assign) BOOL faceServiceEnable;
@property (nonatomic, strong) MGFacepp *markManager;


@property (nonatomic, strong) FHFilterListItem *item;
@property (nonatomic, strong) UILabel *originImageLabel;
@property (nonatomic, strong) UILabel *processedImageLabel;
@property (nonatomic, strong) UIImageView *originImageView;
@property (nonatomic, strong) UIImageView *processedImageView;
@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, strong) UILabel *sliderHintLabel;
@property (nonatomic, strong) GPUImageView *videoImageView;

// GPUImage
@property (nonatomic, strong) GPUImagePicture *sourcePicture;
@property (nonatomic, strong) GPUImageFilter *imageFilter;
@property (nonatomic, strong) GPUImageStillCamera *stillCamera;

@property (nonatomic, assign) ShowType type;

// GPUImageCustomIllusoryFilter
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) NSTimeInterval startTimeInterval;

// Detect
@property (nonatomic, strong) SXSenseDetectTool *detectTool;

#pragma mark - UI
- (void)setupUI;
- (void)layoutConstraints;
- (void)configSliderRange;
- (void)setupCameraUI;
- (void)layoutCameraUIConstraints;
- (void)hiddenSlider;
- (void)showSlider;

#pragma mark - GPUImage
- (void)configFilter;
- (void)render;
- (void)configCameraFilter;
- (void)cameraRender;

#pragma mark - Time Display
- (void)configTimeDisplay;
- (void)createTimer;
- (void)timeAction;

#pragma mark - AdjustFilter
#pragma mark - Color Adjustments
- (void)configBrightness:(CGFloat)brightness;
- (void)configExposure:(CGFloat)exposure;
- (void)configContrast:(CGFloat)contrast;
- (void)configSaturation:(CGFloat)saturation;
- (void)configGamma:(CGFloat)gamma;
- (void)configHue:(CGFloat)hue;
- (void)configOpacity:(CGFloat)opacity;
- (void)configThreshold:(CGFloat)threshold;

#pragma mark - Custom Filters
- (void)configGlitchTime:(CGFloat)time;
- (void)configScaleTime:(CGFloat)time;
- (void)configShakeTime:(CGFloat)time;
- (void)configFlashWhiteTime:(CGFloat)time;
- (void)configIllusionTime:(CGFloat)time;
- (void)configEyeParam:(CGFloat)eyeParam;
- (void)configFaceChangeGroupEyeParam:(CGFloat)eyeParam;

#pragma mark - Handle Detect Result
- (BOOL)needHandleDetectResult;
- (void)handleDetectResultForMaskFilter:(UIImage *)image;
- (void)handleDetectResultForFeaturePointsFilter:(UIImage *)image;
- (void)handleDetectResultForLandmarkFilter:(UIImage *)image;
- (void)handleDetectResultForAddPointsFilter:(UIImage *)image;
- (void)handleDetectResultForFaceChangeFilter:(UIImage *)image;
- (void)handleDetectResultForFaceChangeGroup:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
