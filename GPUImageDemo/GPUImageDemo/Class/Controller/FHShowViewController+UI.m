//
//  ShowViewController+UI.m
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/10.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import "FHShowViewController+UI.h"
#import "FHShowViewController+Private.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
#pragma clang diagnostic ignored "-Wundeclared-selector"

@implementation FHShowViewController (UI)

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
    
    [self addSlider];
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
    
    [self layoutSlider];
}

- (void)layoutSlider {
    if (self.slider) {
        [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.view).mas_offset(50);
            make.trailing.equalTo(self.view).mas_offset(-50);
            make.bottom.equalTo(self.view).mas_offset(-40);
            make.height.mas_equalTo(20);
        }];
    }
    
    if (self.sliderHintLabel) {
        [self.sliderHintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(self.slider);
            make.bottom.equalTo(self.slider.mas_top).mas_offset(-20);
        }];
    }
}

- (void)addSlider {
    NSString *inherit = self.item.inherit;
    NSNumber *parametersNum = self.item.parametersNum;
    if (parametersNum.integerValue == 1 && [inherit isEqualToString:NSStringFromClass([GPUImageFilter class])]) {
        // 只有一个参数的GPUImageFilter
        [self addOneSlider];
    }
    else if (parametersNum.integerValue == 0) {
        // 没有参数
    }
}

- (void)addOneSlider {
    self.slider = [[UISlider alloc] init];
    self.slider.continuous = NO;
    [self.slider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.slider];
    
    self.sliderHintLabel = [[UILabel alloc] init];
    self.sliderHintLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:self.sliderHintLabel];
}

- (void)hiddenSlider {
    self.slider.hidden = YES;
    self.sliderHintLabel.hidden = YES;
}

- (void)showSlider {
    self.slider.hidden = NO;
    self.sliderHintLabel.hidden = NO;
}

- (void)configSliderRange {
    NSString *title = self.item.title;
    if ([title isEqualToString:NSStringFromClass([GPUImageBrightnessFilter class])]) {
        self.slider.minimumValue = -1.0;
        self.slider.maximumValue = 1.0;
        self.slider.value = 0.0;
        self.sliderHintLabel.text = [NSString stringWithFormat:@"brightness(%.1f ~ %.1f): %.1f", self.slider.minimumValue, self.slider.maximumValue, self.slider.value];
    }
    else if ([title isEqualToString:NSStringFromClass([GPUImageExposureFilter class])]) {
        self.slider.minimumValue = -10.0;
        self.slider.maximumValue = 10.0;
        self.slider.value = 0.0;
        self.sliderHintLabel.text = [NSString stringWithFormat:@"exposure(%.1f ~ %.1f): %.1f", self.slider.minimumValue, self.slider.maximumValue, self.slider.value];
    }
    else if ([title isEqualToString:NSStringFromClass([GPUImageContrastFilter class])]) {
        self.slider.minimumValue = 0.0;
        self.slider.maximumValue = 4.0;
        self.slider.value = 1.0;
        self.sliderHintLabel.text = [NSString stringWithFormat:@"contrast(%.1f ~ %.1f): %.1f", self.slider.minimumValue, self.slider.maximumValue, self.slider.value];
    }
    else if ([title isEqualToString:NSStringFromClass([GPUImageSaturationFilter class])]) {
        self.slider.minimumValue = 0.0;
        self.slider.maximumValue = 2.0;
        self.slider.value = 1.0;
        self.sliderHintLabel.text = [NSString stringWithFormat:@"saturation(%.1f ~ %.1f): %.1f", self.slider.minimumValue, self.slider.maximumValue, self.slider.value];
    }
    else if ([title isEqualToString:NSStringFromClass([GPUImageGammaFilter class])]) {
        self.slider.minimumValue = 0.0;
        self.slider.maximumValue = 3.0;
        self.slider.value = 1.0;
        self.sliderHintLabel.text = [NSString stringWithFormat:@"gamma(%.1f ~ %.1f): %.1f", self.slider.minimumValue, self.slider.maximumValue, self.slider.value];
    }
    else if ([title isEqualToString:NSStringFromClass([GPUImageHueFilter class])]) {
        self.slider.minimumValue = 0.0;
        self.slider.maximumValue = 360.0;
        self.slider.value = 90.0;
        self.sliderHintLabel.text = [NSString stringWithFormat:@"hue(%.1f ~ %.1f): %.1f", self.slider.minimumValue, self.slider.maximumValue, self.slider.value];
    }
    else if ([title isEqualToString:NSStringFromClass([GPUImageOpacityFilter class])]) {
        self.slider.minimumValue = 0.0;
        self.slider.maximumValue = 1.0;
        self.slider.value = 1.0;
        self.sliderHintLabel.text = [NSString stringWithFormat:@"hue(%.1f ~ %.1f): %.1f", self.slider.minimumValue, self.slider.maximumValue, self.slider.value];
    }
    else if ([title isEqualToString:NSStringFromClass([GPUImageLuminanceThresholdFilter class])]) {
        self.slider.minimumValue = 0.0;
        self.slider.maximumValue = 1.0;
        self.slider.value = 0.5;
        self.sliderHintLabel.text = [NSString stringWithFormat:@"hue(%.1f ~ %.1f): %.1f", self.slider.minimumValue, self.slider.maximumValue, self.slider.value];
    }
    else if ([title isEqualToString:NSStringFromClass([GPUImageCustomGlitchFilter class])]) {
        self.slider.minimumValue = 0.0;
        self.slider.maximumValue = 6;
        self.slider.value = 0.0;
        self.sliderHintLabel.text = [NSString stringWithFormat:@"time(%.1f ~ %.1f): %.1f", self.slider.minimumValue, self.slider.maximumValue, self.slider.value];
    }
    else if ([title isEqualToString:NSStringFromClass([GPUImageCustomScaleFilter class])]) {
        self.slider.minimumValue = 0.0;
        self.slider.maximumValue = 1.0;
        self.slider.value = 0.0;
        self.sliderHintLabel.text = [NSString stringWithFormat:@"time(%.1f ~ %.1f): %.1f", self.slider.minimumValue, self.slider.maximumValue, self.slider.value];
    }
    else if ([title isEqualToString:NSStringFromClass([GPUImageCustomShakeFilter class])]) {
        self.slider.minimumValue = 0.0;
        self.slider.maximumValue = 1.0;
        self.slider.value = 0.0;
        self.sliderHintLabel.text = [NSString stringWithFormat:@"time(%.1f ~ %.1f): %.1f", self.slider.minimumValue, self.slider.maximumValue, self.slider.value];
    }
    else if ([title isEqualToString:NSStringFromClass([GPUImageCustomFlashWhiteFilter class])]) {
        self.slider.minimumValue = 0.0;
        self.slider.maximumValue = 0.5;
        self.slider.value = 0.0;
        self.sliderHintLabel.text = [NSString stringWithFormat:@"time(%.1f ~ %.1f): %.1f", self.slider.minimumValue, self.slider.maximumValue, self.slider.value];
    }
    else if ([title isEqualToString:NSStringFromClass([GPUImageCustomIllusionFilter class])]) {
        self.slider.minimumValue = 0.0;
        self.slider.maximumValue = 2.0;
        self.slider.value = 0.0;
        self.sliderHintLabel.text = [NSString stringWithFormat:@"time(%.1f ~ %.1f): %.1f", self.slider.minimumValue, self.slider.maximumValue, self.slider.value];
    }
    else if ([title isEqualToString:NSStringFromClass([GPUImageCustomFaceChangeFilter class])]) {
        self.slider.minimumValue = -1.0;
        self.slider.maximumValue = 1.0;
        self.slider.value = 1.0;
        self.sliderHintLabel.text = [NSString stringWithFormat:@"eye(%.1f ~ %.1f): %.1f", self.slider.minimumValue, self.slider.maximumValue, self.slider.value];
    }
}

- (void)sliderChanged:(UISlider *)slider {
    
    CGFloat value = slider.value;
    
    if ([self.imageFilter isKindOfClass:[GPUImageBrightnessFilter class]]) {
        [self configBrightness:value];
        self.sliderHintLabel.text = [NSString stringWithFormat:@"brightness(%.1f ~ %.1f): %.1f", self.slider.minimumValue, self.slider.maximumValue, self.slider.value];
    }
    else if ([self.imageFilter isKindOfClass:[GPUImageExposureFilter class]]) {
        [self configExposure:value];
        self.sliderHintLabel.text = [NSString stringWithFormat:@"exposure(%.1f ~ %.1f): %.1f", self.slider.minimumValue, self.slider.maximumValue, self.slider.value];
    }
    else if ([self.imageFilter isKindOfClass:[GPUImageContrastFilter class]]) {
        [self configContrast:value];
        self.sliderHintLabel.text = [NSString stringWithFormat:@"contrast(%.1f ~ %.1f): %.1f", self.slider.minimumValue, self.slider.maximumValue, self.slider.value];
    }
    else if ([self.imageFilter isKindOfClass:[GPUImageSaturationFilter class]]) {
        [self configSaturation:value];
        self.sliderHintLabel.text = [NSString stringWithFormat:@"saturation(%.1f ~ %.1f): %.1f", self.slider.minimumValue, self.slider.maximumValue, self.slider.value];
    }
    else if ([self.imageFilter isKindOfClass:[GPUImageGammaFilter class]]) {
        [self configGamma:value];
        self.sliderHintLabel.text = [NSString stringWithFormat:@"gamma(%.1f ~ %.1f): %.1f", self.slider.minimumValue, self.slider.maximumValue, self.slider.value];
    }
    else if ([self.imageFilter isKindOfClass:[GPUImageHueFilter class]]) {
        [self configHue:value];
        self.sliderHintLabel.text = [NSString stringWithFormat:@"hue(%.1f ~ %.1f): %.1f", self.slider.minimumValue, self.slider.maximumValue, self.slider.value];
    }
    else if ([self.imageFilter isKindOfClass:[GPUImageOpacityFilter class]]) {
        [self configOpacity:value];
        self.sliderHintLabel.text = [NSString stringWithFormat:@"opacity(%.1f ~ %.1f): %.1f", self.slider.minimumValue, self.slider.maximumValue, self.slider.value];
    }
    else if ([self.imageFilter isKindOfClass:[GPUImageLuminanceThresholdFilter class]]) {
        [self configThreshold:value];
        self.sliderHintLabel.text = [NSString stringWithFormat:@"threshold(%.1f ~ %.1f): %.1f", self.slider.minimumValue, self.slider.maximumValue, self.slider.value];
    }
    else if ([self.imageFilter isKindOfClass:[GPUImageCustomGlitchFilter class]]) {
        [self configGlitchTime:value];
        self.sliderHintLabel.text = [NSString stringWithFormat:@"time(%.1f ~ %.1f): %.1f", self.slider.minimumValue, self.slider.maximumValue, self.slider.value];
    }
    else if ([self.imageFilter isKindOfClass:[GPUImageCustomScaleFilter class]]) {
        [self configScaleTime:value];
        self.sliderHintLabel.text = [NSString stringWithFormat:@"time(%.1f ~ %.1f): %.1f", self.slider.minimumValue, self.slider.maximumValue, self.slider.value];
    }
    else if ([self.imageFilter isKindOfClass:[GPUImageCustomShakeFilter class]]) {
        [self configShakeTime:value];
        self.sliderHintLabel.text = [NSString stringWithFormat:@"time(%.1f ~ %.1f): %.1f", self.slider.minimumValue, self.slider.maximumValue, self.slider.value];
    }
    else if ([self.imageFilter isKindOfClass:[GPUImageCustomFlashWhiteFilter class]]) {
        [self configFlashWhiteTime:value];
        self.sliderHintLabel.text = [NSString stringWithFormat:@"time(%.1f ~ %.1f): %.1f", self.slider.minimumValue, self.slider.maximumValue, self.slider.value];
    }
    else if ([self.imageFilter isKindOfClass:[GPUImageCustomIllusionFilter class]]) {
        [self configIllusionTime:value];
        self.sliderHintLabel.text = [NSString stringWithFormat:@"time(%.1f ~ %.1f): %.1f", self.slider.minimumValue, self.slider.maximumValue, self.slider.value];
    }
    else if ([self.imageFilter isKindOfClass:[GPUImageCustomFaceChangeFilter class]]) {
        [self configEyeParam:value];
        self.sliderHintLabel.text = [NSString stringWithFormat:@"eye(%.1f ~ %.1f): %.1f", self.slider.minimumValue, self.slider.maximumValue, self.slider.value];
    }
    if (self.type == ShowTypeImage) {
        
        [self render];
    }
}

@end

#pragma clang diagnostic pop
