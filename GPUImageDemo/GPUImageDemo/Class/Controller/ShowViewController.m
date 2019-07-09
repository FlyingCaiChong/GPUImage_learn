//
//  ShowViewController.m
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/9.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import "ShowViewController.h"

@interface ShowViewController ()

@property (nonatomic, strong) UILabel *originImageLabel;
@property (nonatomic, strong) UILabel *processedImageLabel;
@property (nonatomic, strong) UIImageView *originImageView;
@property (nonatomic, strong) UIImageView *processedImageView;
@property (nonatomic, strong) UISlider *slider;

@end

@implementation ShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self layoutConstraints];
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
        _originImageView.image = [UIImage imageNamed:@"img_test"];
    }
    return _originImageView;
}

- (UIImageView *)processedImageView {
    if (!_processedImageView) {
        _processedImageView = [[UIImageView alloc] init];
        _processedImageView.image = [UIImage imageNamed:@"img_test"];
    }
    return _processedImageView;
}

- (UISlider *)slider {
    if (!_slider) {
        _slider = [[UISlider alloc] init];
    }
    return _slider;
}

@end
