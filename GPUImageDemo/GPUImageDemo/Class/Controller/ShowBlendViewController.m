//
//  ShowBlendViewController.m
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/11.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import "ShowBlendViewController.h"
#import "ShowBlendViewController+Private.h"
#import "ShowBlendViewController+UI.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"
@interface ShowBlendViewController ()

@end

@implementation ShowBlendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imageA = [UIImage imageNamed:kImageNamedA];
    self.imageB = [UIImage imageNamed:kImageNamedB];
    
    [self setupUI];
    [self layoutConstraints];
    [self configFilters];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self render];
}

- (void)configFilters {
    NSString *filterClassNamed = self.item.title;
    self.blendImageFilter = (GPUImageTwoInputFilter *)[[NSClassFromString(filterClassNamed) alloc] init];
    [self.sourcePictureA addTarget:self.blendImageFilter];
    [self.sourcePictureB addTarget:self.blendImageFilter];
}

- (void)render {
    [self.blendImageFilter useNextFrameForImageCapture];
    [self.sourcePictureA forceProcessingAtSize:self.imageA.size];
    [self.sourcePictureA processImage];
    [self.sourcePictureB forceProcessingAtSize:self.imageB.size];
    [self.sourcePictureB processImage];
    self.resultBlendImageView.image = [self.blendImageFilter imageFromCurrentFramebuffer];
}

#pragma mark - lazy
- (GPUImagePicture *)sourcePictureA {
    if (!_sourcePictureA) {
        _sourcePictureA = [[GPUImagePicture alloc] initWithImage:self.imageA];
    }
    return _sourcePictureA;
}

- (GPUImagePicture *)sourcePictureB {
    if (!_sourcePictureB) {
        _sourcePictureB = [[GPUImagePicture alloc] initWithImage:self.imageB];
    }
    return _sourcePictureB;
}

@end
#pragma clang diagnostic pop
