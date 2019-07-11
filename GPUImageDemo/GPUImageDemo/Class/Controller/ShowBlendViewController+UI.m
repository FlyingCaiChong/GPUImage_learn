//
//  ShowBlendViewController+UI.m
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/11.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import "ShowBlendViewController+UI.h"
#import "ShowBlendViewController+Private.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
#pragma clang diagnostic ignored "-Wundeclared-selector"
@implementation ShowBlendViewController (UI)

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.originContainerView = [[UIView alloc] init];
    self.originContainerView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.originContainerView];
    
    self.resultContainerView = [[UIView alloc] init];
    self.resultContainerView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.resultContainerView];
    
    self.originImageALabel = [[UILabel alloc] init];
    self.originImageALabel.text = @"图像A";
    [self.originContainerView addSubview:self.originImageALabel];
    
    self.originImageBLabel = [[UILabel alloc] init];
    self.originImageBLabel.text = @"图像B";
    [self.originContainerView addSubview:self.originImageBLabel];
    
    self.originImageAImageView = [[UIImageView alloc] initWithImage:self.imageA];
    self.originImageAImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.originContainerView addSubview:self.originImageAImageView];
    
    self.originImageBImageView = [[UIImageView alloc] initWithImage:self.imageB];
    self.originImageBImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.originContainerView addSubview:self.originImageBImageView];
    
    self.resultBlendLabel = [[UILabel alloc] init];
    self.resultBlendLabel.text = @"混合结果";
    [self.resultContainerView addSubview:self.resultBlendLabel];
    
    self.resultBlendImageView = [[UIImageView alloc] init];
    self.resultBlendImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.resultContainerView addSubview:self.resultBlendImageView];
}

- (void)layoutConstraints {
    
    [self.originContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).mas_offset(0);
    }];
    
    [self.resultContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.trailing.equalTo(self.view);
        make.top.equalTo(self.originContainerView.mas_bottom).mas_offset(0);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).mas_offset(0);
        make.height.equalTo(self.originContainerView);
    }];
    
    [self.originImageAImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.originContainerView);
        make.bottom.equalTo(self.originContainerView).mas_offset(-50);
        make.leading.equalTo(self.originContainerView).mas_offset(30);
        make.height.equalTo(self.originContainerView.mas_height).mas_offset(-100);
    }];
    
    [self.originImageBImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.originContainerView);
        make.bottom.equalTo(self.originContainerView).mas_offset(-50);
        make.trailing.equalTo(self.originContainerView).mas_offset(-30);
        make.leading.equalTo(self.originImageAImageView.mas_trailing).mas_offset(60);
        make.width.height.equalTo(self.originImageAImageView);
    }];
    
    [self.originImageALabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.originImageAImageView);
        make.bottom.equalTo(self.originImageAImageView.mas_top).mas_offset(-5);
    }];
    
    [self.originImageBLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.originImageBImageView);
        make.bottom.equalTo(self.originImageBImageView.mas_top).mas_offset(-5);
    }];
    
    [self.resultBlendImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.resultContainerView);
        make.bottom.equalTo(self.resultContainerView).mas_offset(-50);
        make.leading.equalTo(self.resultContainerView).mas_offset(50);
    }];
}

@end
#pragma clang diagnostic pop
