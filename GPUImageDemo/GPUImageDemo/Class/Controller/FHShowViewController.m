//
//  ShowViewController.m
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/9.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import "FHShowViewController.h"
#import "GPUImage.h"
#import "FHShowViewController+Private.h"
#import "FHShowViewController+UI.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"

@implementation FHShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.type == ShowTypeImage) {
        
        [self setupUI];
        [self layoutConstraints];
        [self configSliderRange];
        [self configFilter];
    } else {
        
        [self setupCameraUI];
        [self layoutCameraUIConstraints];
        [self configSliderRange];
        [self configCameraFilter];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.type == ShowTypeImage) {
        
        [self render];
    } else {
        [self.navigationController.navigationBar setHidden:YES];
        [self cameraRender];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.type == ShowTypeCamera) {
        [self.navigationController.navigationBar setHidden:NO];
    }
}

- (BOOL)prefersStatusBarHidden {
    if (self.type == ShowTypeCamera) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - Image
- (void)configFilter {
    NSString *filterClassNamed = self.item.title;
    self.imageFilter = (GPUImageFilter *)[[NSClassFromString(filterClassNamed) alloc] init];
    [self.sourcePicture addTarget:self.imageFilter];
}

- (void)render {
    [self.imageFilter useNextFrameForImageCapture];
    [self.sourcePicture processImage];
    self.processedImageView.image = [self.imageFilter imageFromCurrentFramebuffer];
}

#pragma mark - Camera
- (void)configCameraFilter {
    NSString *filterClassNamed = self.item.title;
    self.imageFilter = (GPUImageFilter *)[[NSClassFromString(filterClassNamed) alloc] init];
    [self.stillCamera addTarget:self.imageFilter];
    [self.imageFilter addTarget:self.videoImageView];
}

- (void)cameraRender {
    [self.stillCamera startCameraCapture];
}

#pragma mark - lazy
- (GPUImagePicture *)sourcePicture {
    if (!_sourcePicture) {
        _sourcePicture = [[GPUImagePicture alloc] initWithImage:[UIImage imageNamed:kImageNamed]];
    }
    return _sourcePicture;
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


