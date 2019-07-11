//
//  ShowBlendViewController+UI.m
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/11.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import "FHShowBlendViewController+UI.h"
#import "FHShowBlendViewController+Private.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
#pragma clang diagnostic ignored "-Wundeclared-selector"
@implementation FHShowBlendViewController (UI)

#pragma mark - Camera
- (void)setupCameraUI {
    self.videoImageView = [[GPUImageView alloc] init];
    [self.view addSubview:self.videoImageView];
    
    [self addSlider];
}

- (void)layoutCameraUIConstraints {
    [self.videoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).mas_offset(0);
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).mas_offset(0);
    }];
    
    [self layoutSlider];
}

#pragma mark - Image
- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.originContainerView = [[UIView alloc] init];
    [self.view addSubview:self.originContainerView];
    
    self.resultContainerView = [[UIView alloc] init];
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
    
    [self addSlider];
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
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).mas_offset(-100);
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
    
    [self.resultBlendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.resultBlendImageView);
        make.bottom.equalTo(self.resultBlendImageView.mas_top).mas_offset(-15);
    }];
    
    [self layoutSlider];
}

- (void)layoutSlider {
    if (self.sliderA) {
        [self.sliderA mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.view).mas_offset(50);
            make.trailing.equalTo(self.view).mas_offset(-50);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).mas_offset(-20);
            make.height.mas_equalTo(20);
        }];
    }
    if (self.sliderAHintLabel) {
        [self.sliderAHintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(self.sliderA);
            make.bottom.equalTo(self.sliderA.mas_top).mas_offset(-10);
        }];
    }
    if (self.sliderB) {
        [self.sliderB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(self.sliderA);
            make.bottom.equalTo(self.sliderAHintLabel.mas_top).mas_offset(-10);
            make.height.mas_equalTo(20);
        }];
    }
    if (self.sliderBHintLabel) {
        [self.sliderBHintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(self.sliderB);
            make.bottom.equalTo(self.sliderB.mas_top).mas_offset(-10);
        }];
    }
}

- (void)addSlider {

    NSNumber *parametersNum = self.item.parametersNum;
    if (parametersNum.integerValue == 1) {
        // 只有一个参数
        [self addSliderA];
    }
    else if (parametersNum.integerValue == 2) {
        // 有两个参数
        [self addSliderA];
        [self addSliderB];
    } else {
        // 没有参数
    }
}

- (void)addSliderA {
    self.sliderA = [[UISlider alloc] init];
    self.sliderA.continuous = NO;
    [self.sliderA addTarget:self action:@selector(sliderAChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.sliderA];
    
    self.sliderAHintLabel = [[UILabel alloc] init];
    self.sliderAHintLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:self.sliderAHintLabel];
}

- (void)addSliderB {
    self.sliderB = [[UISlider alloc] init];
    self.sliderB.continuous = NO;
    [self.sliderB addTarget:self action:@selector(sliderBChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.sliderB];
    
    self.sliderBHintLabel = [[UILabel alloc] init];
    self.sliderBHintLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:self.sliderBHintLabel];
}

- (void)configSliderRange {
    NSString *title = self.item.title;
    if ([title isEqualToString:NSStringFromClass([GPUImageChromaKeyBlendFilter class])]) {
        self.sliderA.minimumValue = 0.0;
        self.sliderA.maximumValue = 1.0;
        self.sliderA.value = 0.4;
        self.sliderAHintLabel.text = [NSString stringWithFormat:@"thresholdSensitivity(%.1f ~ %.1f): %.1f", self.sliderA.minimumValue, self.sliderA.maximumValue, self.sliderA.value];
        self.sliderB.minimumValue = 0.0;
        self.sliderB.maximumValue = 1.0;
        self.sliderB.value = 0.1;
        self.sliderBHintLabel.text = [NSString stringWithFormat:@"smoothing(%.1f ~ %.1f): %.1f", self.sliderB.minimumValue, self.sliderB.maximumValue, self.sliderB.value];
    }
    else if ([title isEqualToString:NSStringFromClass([GPUImageDissolveBlendFilter class])]) {
        self.sliderA.minimumValue = 0.0;
        self.sliderA.maximumValue = 1.0;
        self.sliderA.value = 0.5;
        self.sliderAHintLabel.text = [NSString stringWithFormat:@"mix(%.1f ~ %.1f): %.1f", self.sliderA.minimumValue, self.sliderA.maximumValue, self.sliderA.value];
    }
    else if ([title isEqualToString:NSStringFromClass([GPUImageAlphaBlendFilter class])]) {
        self.sliderA.minimumValue = 0.0;
        self.sliderA.maximumValue = 1.0;
        self.sliderA.value = 1.0;
        self.sliderAHintLabel.text = [NSString stringWithFormat:@"mix(%.1f ~ %.1f): %.1f", self.sliderA.minimumValue, self.sliderA.maximumValue, self.sliderA.value];
    }
    else if ([title isEqualToString:NSStringFromClass([GPUImagePoissonBlendFilter class])]) {
        self.sliderA.minimumValue = 0.0;
        self.sliderA.maximumValue = 1.0;
        self.sliderA.value = 1.0;
        self.sliderAHintLabel.text = [NSString stringWithFormat:@"mix(%.1f ~ %.1f): %.1f", self.sliderA.minimumValue, self.sliderA.maximumValue, self.sliderA.value];
        self.sliderB.minimumValue = 1;
        self.sliderB.maximumValue = 100;
        self.sliderB.value = 1;
        self.sliderBHintLabel.text = [NSString stringWithFormat:@"numIterations(%.f ~ %.f): %.f", self.sliderB.minimumValue, self.sliderB.maximumValue, self.sliderB.value];
    }
}

- (void)sliderAChanged:(UISlider *)slider {
    CGFloat value = slider.value;
    if ([self.blendImageFilter isKindOfClass:[GPUImageChromaKeyBlendFilter class]]) {
        [self configThresholdSensitivity:value];
        self.sliderAHintLabel.text = [NSString stringWithFormat:@"thresholdSensitivity(%.1f ~ %.1f): %.1f", self.sliderA.minimumValue, self.sliderA.maximumValue, self.sliderA.value];
    }
    else if ([self.blendImageFilter isKindOfClass:[GPUImageDissolveBlendFilter class]]) {
        [self configDissolveMix:value];
        self.sliderAHintLabel.text = [NSString stringWithFormat:@"mix(%.1f ~ %.1f): %.1f", self.sliderA.minimumValue, self.sliderA.maximumValue, self.sliderA.value];
    }
    else if ([self.blendImageFilter isKindOfClass:[GPUImageAlphaBlendFilter class]]) {
        [self configAlphaMix:value];
        self.sliderAHintLabel.text = [NSString stringWithFormat:@"mix(%.1f ~ %.1f): %.1f", self.sliderA.minimumValue, self.sliderA.maximumValue, self.sliderA.value];
    }
    else if ([self.blendImageFilter isKindOfClass:[GPUImagePoissonBlendFilter class]]) {
        [self configPoissonMix:value];
        self.sliderAHintLabel.text = [NSString stringWithFormat:@"mix(%.1f ~ %.1f): %.1f", self.sliderA.minimumValue, self.sliderA.maximumValue, self.sliderA.value];
    }
    
    [self render];
}

- (void)sliderBChanged:(UISlider *)slider {
    CGFloat value = slider.value;
    
    if ([self.blendImageFilter isKindOfClass:[GPUImageChromaKeyBlendFilter class]]) {
        [self configSmoothing:value];
        self.sliderBHintLabel.text = [NSString stringWithFormat:@"smoothing(%.1f ~ %.1f): %.1f", self.sliderB.minimumValue, self.sliderB.maximumValue, self.sliderB.value];
    }
    else if ([self.blendImageFilter isKindOfClass:[GPUImagePoissonBlendFilter class]]) {
        NSUInteger intValue = ceilf(value);
        [self configPoissonNumIterations:intValue];
        self.sliderBHintLabel.text = [NSString stringWithFormat:@"numIterations(%.f ~ %.f): %.f", self.sliderB.minimumValue, self.sliderB.maximumValue, self.sliderB.value];
    }
    
    [self render];
}

@end
#pragma clang diagnostic pop
