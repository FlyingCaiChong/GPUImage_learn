//
//  ShowViewController.m
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/9.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import "ShowViewController.h"
#import "GPUImage.h"

static NSString *const kImageNamed = @"img_test";

@interface ShowViewController ()

@property (nonatomic, strong) UILabel *originImageLabel;
@property (nonatomic, strong) UILabel *processedImageLabel;
@property (nonatomic, strong) UIImageView *originImageView;
@property (nonatomic, strong) UIImageView *processedImageView;
@property (nonatomic, strong) UISlider *slider;

// GPUImage
@property (nonatomic, strong) GPUImagePicture *sourcePicture;
@property (nonatomic, strong) GPUImageFilter *imageFilter;

@end

@implementation ShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self layoutConstraints];
    [self configFilter];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self render];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.originImageLabel];
    [self.view addSubview:self.processedImageLabel];
    [self.view addSubview:self.originImageView];
    [self.view addSubview:self.processedImageView];
    [self.view addSubview:self.slider];
}

- (void)layoutConstraints {
    
    [self.originImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).mas_offset(10);
        make.centerY.equalTo(self.view);
        make.height.mas_equalTo(224);
    }];
    
    [self.processedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.originImageView.mas_trailing).mas_offset(10);
        make.trailing.equalTo(self.view).mas_offset(-10);
        make.centerY.equalTo(self.originImageView);
        make.width.height.equalTo(self.originImageView);
    }];
    
    [self.originImageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.originImageView.mas_top).mas_offset(-10);
        make.centerX.equalTo(self.originImageView);
    }];
    
    [self.processedImageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.processedImageView.mas_top).mas_offset(-10);
        make.centerX.equalTo(self.processedImageView);
    }];
    
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).mas_offset(50);
        make.trailing.equalTo(self.view).mas_offset(-50);
        make.bottom.equalTo(self.view).mas_offset(-40);
        make.height.mas_equalTo(20);
    }];
}

- (void)configFilter {
    NSString *filterClassNamed = self.item.title;
    self.imageFilter = (GPUImageFilter *)[[NSClassFromString(filterClassNamed) alloc] init];
    [self.sourcePicture addTarget:self.imageFilter];
    [self.imageFilter useNextFrameForImageCapture];
}

- (void)render {
    [self.sourcePicture processImage];
    self.processedImageView.image = [self.imageFilter imageFromCurrentFramebuffer];
}

#pragma mark - lazy
- (UILabel *)originImageLabel {
    if (!_originImageLabel) {
        _originImageLabel = [[UILabel alloc] init];
        _originImageLabel.text = @"原图";
        _originImageLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _originImageLabel;
}

- (UILabel *)processedImageLabel {
    if (!_processedImageLabel) {
        _processedImageLabel = [[UILabel alloc] init];
        _processedImageLabel.text = @"处理后图";
        _processedImageLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _processedImageLabel;
}

- (UIImageView *)originImageView {
    if (!_originImageView) {
        _originImageView = [[UIImageView alloc] init];
        _originImageView.image = [UIImage imageNamed:kImageNamed];
    }
    return _originImageView;
}

- (UIImageView *)processedImageView {
    if (!_processedImageView) {
        _processedImageView = [[UIImageView alloc] init];
    }
    return _processedImageView;
}

- (UISlider *)slider {
    if (!_slider) {
        _slider = [[UISlider alloc] init];
    }
    return _slider;
}

- (GPUImagePicture *)sourcePicture {
    if (!_sourcePicture) {
        _sourcePicture = [[GPUImagePicture alloc] initWithImage:[UIImage imageNamed:kImageNamed]];
    }
    return _sourcePicture;
}


@end
