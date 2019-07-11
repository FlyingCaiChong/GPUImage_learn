//
//  ShowBlendViewController.m
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/11.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import "FHShowBlendViewController.h"
#import "FHShowBlendViewController+Private.h"
#import "FHShowBlendViewController+UI.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"
@interface FHShowBlendViewController ()

@end

@implementation FHShowBlendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imageA = [UIImage imageNamed:kImageNamedA];
    self.imageB = [UIImage imageNamed:kImageNamedB];
    
    if (self.type == BlendShowTypeImage) {
        
        [self setupUI];
        [self layoutConstraints];
        [self configSliderRange];
        [self configFilters];
    } else {
        
        [self setupCameraUI];
        [self layoutCameraUIConstraints];
        [self configSliderRange];
        [self configCameraFilter];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.type == BlendShowTypeImage) {
        
        [self render];
    } else {
        [self.navigationController.navigationBar setHidden:YES];
        [self cameraRender];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setHidden:NO];
}

- (BOOL)prefersStatusBarHidden {
    if (self.type == BlendShowTypeImage) {
        return NO;
    } else {
        return YES;
    }
}

#pragma mark - Image
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

#pragma mark - Camera
- (void)configCameraFilter {
    NSString *filterClassNamed = self.item.title;
    self.blendImageFilter = (GPUImageTwoInputFilter *)[[NSClassFromString(filterClassNamed) alloc] init];
    [self.stillCamera addTarget:self.blendImageFilter];
    [self.sourcePictureB addTarget:self.blendImageFilter];
    [self.blendImageFilter addTarget:self.videoImageView];
}

- (void)cameraRender {
    [self.sourcePictureA forceProcessingAtSize:self.imageB.size];
    [self.sourcePictureB processImage];
    [self.stillCamera startCameraCapture];
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

- (GPUImageStillCamera *)stillCamera {
    if (!_stillCamera) {
        _stillCamera = [[GPUImageStillCamera alloc] initWithSessionPreset:AVCaptureSessionPresetHigh cameraPosition:(AVCaptureDevicePositionFront)];
        _stillCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
        _stillCamera.horizontallyMirrorFrontFacingCamera = YES;
    }
    return _stillCamera;
}

@end
#pragma clang diagnostic pop
