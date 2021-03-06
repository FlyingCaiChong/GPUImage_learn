//
//  ShowBlendViewController+Private.h
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/11.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import "FHShowBlendViewController.h"
#import "GPUImage.h"
#import "FHFilterListItem.h"

NS_ASSUME_NONNULL_BEGIN

static NSString *const kImageNamedA = @"img_test";
static NSString *const kImageNamedB = @"grass";

typedef NS_ENUM(NSUInteger, BlendShowType) {
    BlendShowTypeImage,
    BlendShowTypeCamera,
};

@interface FHShowBlendViewController ()

@property (nonatomic, strong) FHFilterListItem *item;

@property (nonatomic, strong) UIView *originContainerView;
@property (nonatomic, strong) UIView *resultContainerView;
@property (nonatomic, strong) UILabel *originImageALabel;
@property (nonatomic, strong) UILabel *originImageBLabel;
@property (nonatomic, strong) UIImageView *originImageAImageView;
@property (nonatomic, strong) UIImageView *originImageBImageView;
@property (nonatomic, strong) UILabel *resultBlendLabel;
@property (nonatomic, strong) UIImageView *resultBlendImageView;
@property (nonatomic, strong) UISlider *sliderA;
@property (nonatomic, strong) UISlider *sliderB;
@property (nonatomic, strong) UILabel *sliderAHintLabel;
@property (nonatomic, strong) UILabel *sliderBHintLabel;
@property (nonatomic, strong) GPUImageView *videoImageView;


@property (nonatomic, strong) GPUImagePicture *sourcePictureA;
@property (nonatomic, strong) GPUImagePicture *sourcePictureB;
@property (nonatomic, strong) GPUImageTwoInputFilter *blendImageFilter;
@property (nonatomic, strong) UIImage *imageA;
@property (nonatomic, strong) UIImage *imageB;
@property (nonatomic, strong) GPUImageStillCamera *stillCamera;

@property (nonatomic, assign) BlendShowType type;

#pragma mark - UI
- (void)setupUI;
- (void)layoutConstraints;
- (void)configSliderRange;
- (void)setupCameraUI;
- (void)layoutCameraUIConstraints;

#pragma mark - Filter
- (void)configFilters;
- (void)render;
- (void)configCameraFilter;
- (void)cameraRender;

#pragma mark - Adjust
- (void)configThresholdSensitivity:(CGFloat)thresholdSensitivity;
- (void)configSmoothing:(CGFloat)smoothing;
- (void)configDissolveMix:(CGFloat)mix;
- (void)configAlphaMix:(CGFloat)mix;
- (void)configPoissonMix:(CGFloat)mix;
- (void)configPoissonNumIterations:(NSUInteger)numIterations;

@end

NS_ASSUME_NONNULL_END
