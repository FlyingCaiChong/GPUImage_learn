//
//  ShowBlendViewController+Private.h
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/11.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import "ShowBlendViewController.h"
#import "GPUImage.h"
#import "FilterListItem.h"

NS_ASSUME_NONNULL_BEGIN

static NSString *const kImageNamedA = @"img_test";
static NSString *const kImageNamedB = @"grass";

@interface ShowBlendViewController ()

@property (nonatomic, strong) UIView *originContainerView;
@property (nonatomic, strong) UIView *resultContainerView;
@property (nonatomic, strong) UILabel *originImageALabel;
@property (nonatomic, strong) UILabel *originImageBLabel;
@property (nonatomic, strong) UIImageView *originImageAImageView;
@property (nonatomic, strong) UIImageView *originImageBImageView;
@property (nonatomic, strong) UILabel *resultBlendLabel;
@property (nonatomic, strong) UIImageView *resultBlendImageView;

@property (nonatomic, strong) FilterListItem *item;

@property (nonatomic, strong) GPUImagePicture *sourcePictureA;
@property (nonatomic, strong) GPUImagePicture *sourcePictureB;
@property (nonatomic, strong) GPUImageTwoInputFilter *blendImageFilter;
@property (nonatomic, strong) UIImage *imageA;
@property (nonatomic, strong) UIImage *imageB;

#pragma mark - UI
- (void)setupUI;
- (void)layoutConstraints;

#pragma mark - Filter
- (void)configFilters;
- (void)render;

@end

NS_ASSUME_NONNULL_END
