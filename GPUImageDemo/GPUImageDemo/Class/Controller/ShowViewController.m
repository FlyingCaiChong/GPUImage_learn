//
//  ShowViewController.m
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/9.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import "ShowViewController.h"
#import "GPUImage.h"
#import "ShowViewController+Private.h"
#import "ShowViewController+UI.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"

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

- (GPUImagePicture *)sourcePicture {
    if (!_sourcePicture) {
        _sourcePicture = [[GPUImagePicture alloc] initWithImage:[UIImage imageNamed:kImageNamed]];
    }
    return _sourcePicture;
}

@end
#pragma clang diagnostic pop


