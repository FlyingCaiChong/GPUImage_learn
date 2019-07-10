//
//  ShowViewController+Private.h
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/10.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import "ShowViewController.h"
#import "GPUImage.h"
#import "FilterListItem.h"

NS_ASSUME_NONNULL_BEGIN

static NSString *const kImageNamed = @"img_test";

@interface ShowViewController ()

@property (nonatomic, strong) FilterListItem *item;
@property (nonatomic, strong) UILabel *originImageLabel;
@property (nonatomic, strong) UILabel *processedImageLabel;
@property (nonatomic, strong) UIImageView *originImageView;
@property (nonatomic, strong) UIImageView *processedImageView;
@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, strong) UILabel *sliderHintLabel;

// GPUImage
@property (nonatomic, strong) GPUImagePicture *sourcePicture;
@property (nonatomic, strong) GPUImageFilter *imageFilter;

#pragma mark - UI
- (void)setupUI;
- (void)layoutConstraints;
- (void)configSliderRange;

#pragma mark - GPUImage
- (void)configFilter;
- (void)render;

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


@end

NS_ASSUME_NONNULL_END
