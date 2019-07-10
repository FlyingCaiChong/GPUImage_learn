//
//  ShowViewController+UI.m
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/10.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import "ShowViewController+UI.h"
#import "ShowViewController+Private.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
#pragma clang diagnostic ignored "-Wundeclared-selector"

@implementation ShowViewController (UI)

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.originImageLabel = [[UILabel alloc] init];
    self.originImageLabel.text = @"原图";
    self.originImageLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.originImageLabel];
    
    self.processedImageLabel = [[UILabel alloc] init];
    self.processedImageLabel.text = @"处理后图";
    self.processedImageLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.processedImageLabel];
    
    self.originImageView = [[UIImageView alloc] init];
    self.originImageView.image = [UIImage imageNamed:kImageNamed];
    [self.view addSubview:self.originImageView];
    
     self.processedImageView = [[UIImageView alloc] init];
    [self.view addSubview:self.processedImageView];
    
    self.slider = [[UISlider alloc] init];
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

@end

#pragma clang diagnostic pop
