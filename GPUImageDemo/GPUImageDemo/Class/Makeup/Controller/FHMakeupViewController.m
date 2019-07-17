//
//  FHMakeupViewController.m
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/16.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import "FHMakeupViewController.h"
#import "GPUImage.h"
#import "SXSenseDetectTool.h"
#import "UIImage+SXExtension.h"

@interface FHMakeupViewController ()<GPUImageVideoCameraDelegate>

@property (nonatomic, strong) GPUImagePicture *imagePicture;
@property (nonatomic, strong) GPUImageHarrisCornerDetectionFilter *detectionFilter;
@property (nonatomic, strong) GPUImageCrosshairGenerator *crosshairGenerator;
@property (nonatomic, strong) GPUImageAlphaBlendFilter *alphaBlendFilter;
@property (nonatomic, strong) GPUImageGammaFilter *gammaFilter;
@property (nonatomic, strong) GPUImageView *videoImageView;
@property (nonatomic, strong) UIImageView *showImageView;
@property (nonatomic, strong) SXSenseDetectTool *detectTool;
@property (nonatomic, strong) GPUImageStillCamera *stillCamera;

@end

@implementation FHMakeupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCameraUI];
    [self layoutCameraUIConstraints];
//    [self setupFilter];
    [self setupCameraFilter];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [self cameraRender];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)setupCameraUI {
    self.videoImageView = [[GPUImageView alloc] init];
    [self.view addSubview:self.videoImageView];
}

- (void)layoutCameraUIConstraints {
    [self.videoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).mas_offset(0);
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).mas_offset(0);
    }];
}

- (void)setupFilter {
    [self testFeaturePointsFilterWithImage:[UIImage imageNamed:@"img_test"]];
}

- (void)testFeaturePointsFilterWithImage:(UIImage *)image {
    
    self.crosshairGenerator = [[GPUImageCrosshairGenerator alloc] init];
    self.crosshairGenerator.crosshairWidth = 10.0;
    [self.crosshairGenerator setCrosshairColorRed:1.0 green:0.0 blue:0.0];
    [self.crosshairGenerator forceProcessingAtSize:[self.imagePicture outputImageSize]];
    
    self.alphaBlendFilter = [[GPUImageAlphaBlendFilter alloc] init];
    [self.imagePicture addTarget:self.alphaBlendFilter];
    [self.crosshairGenerator addTarget:self.alphaBlendFilter];
    [self.alphaBlendFilter useNextFrameForImageCapture];
    
    // 获取原图宽度
    int imageWidth = (int)CGImageGetWidth(image.CGImage);
    // 获取原图高度
    int imageHeight = (int)CGImageGetHeight(image.CGImage);
    
    NSArray *pointsArr = [[self.detectTool resultForDetectWithImage:image] copy];
    NSLog(@"pointArr: %@", pointsArr);
    int count = (int)(pointsArr.count * 2);
    GLfloat points[count];
    
    for (int i = 0; i < pointsArr.count; i++) {
        NSValue *pointValue = pointsArr[i];
        CGPoint point = [pointValue CGPointValue];
        points[2 * i] = point.x/(imageWidth * 1.0);
        points[2 * i + 1] = point.y/(imageHeight * 1.0);
    }
    
    // 准备数据
    CMTime frameTime = CMTimeMake(0, 1);
    [self.crosshairGenerator forceProcessingAtSize:CGSizeMake(imageWidth, imageHeight)];
    [self.crosshairGenerator renderCrosshairsFromArray:points count:pointsArr.count frameTime:frameTime];
    [self.imagePicture processImage];

    UIImage *resultImage = [self.alphaBlendFilter imageFromCurrentFramebuffer];
    self.showImageView.image = resultImage;
}


- (void)setupCameraFilter {
    
    self.crosshairGenerator = [[GPUImageCrosshairGenerator alloc] init];
    self.crosshairGenerator.crosshairWidth = 10.0;
    [self.crosshairGenerator setCrosshairColorRed:1.0 green:0.0 blue:0.0];
//    [self.crosshairGenerator forceProcessingAtSize:[self.imagePicture outputImageSize]];
    
    self.alphaBlendFilter = [[GPUImageAlphaBlendFilter alloc] init];
    [self.stillCamera addTarget:self.alphaBlendFilter];
    [self.crosshairGenerator addTarget:self.alphaBlendFilter];
//    [self.alphaBlendFilter useNextFrameForImageCapture];
    [self.alphaBlendFilter addTarget:self.videoImageView];
}

- (void)cameraRender {
    [self.stillCamera startCameraCapture];
}

- (void)testFeaturePointsFilterWithCameraImage:(UIImage *)image {
    // 获取原图宽度
    int imageWidth = (int)CGImageGetWidth(image.CGImage);
    // 获取原图高度
    int imageHeight = (int)CGImageGetHeight(image.CGImage);
    
    NSArray *pointsArr = [[self.detectTool resultForDetectWithImage:image] copy];
    NSLog(@"pointArr: %@", pointsArr);
    int count = (int)(pointsArr.count * 2);
    GLfloat points[count];
    
    for (int i = 0; i < pointsArr.count; i++) {
        NSValue *pointValue = pointsArr[i];
        CGPoint point = [pointValue CGPointValue];
        points[2 * i] = point.x/(imageWidth * 1.0);
        points[2 * i + 1] = point.y/(imageHeight * 1.0);
    }
    
    // 准备数据
    CMTime frameTime = CMTimeMake(0, 1);
//    [self.crosshairGenerator forceProcessingAtSize:CGSizeMake(imageWidth, imageHeight)];
    [self.crosshairGenerator renderCrosshairsFromArray:points count:pointsArr.count frameTime:frameTime];
}

#pragma mark - GPUImageVideoCameraDelegate
- (void)willOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer {
    CMSampleBufferRef picCopy; // 避免内存问题产生，此处Copy一份Buffer用作处理；
    CMSampleBufferCreateCopy(CFAllocatorGetDefault(), sampleBuffer, &picCopy);
    UIImage *tempImage = [UIImage imageFromSampleBuffer:(__bridge CMSampleBufferRef)(CFBridgingRelease(picCopy))];
    [self testFeaturePointsFilterWithCameraImage:tempImage];
}

#pragma mark - lazy

- (GPUImagePicture *)imagePicture {
    if (!_imagePicture) {
        _imagePicture = [[GPUImagePicture alloc] initWithImage:[UIImage imageNamed:@"img_test"]];
    }
    return _imagePicture;
}

- (SXSenseDetectTool *)detectTool {
    if (!_detectTool) {
        _detectTool = [SXSenseDetectTool sharedInstance];
    }
    return _detectTool;
}

- (GPUImageStillCamera *)stillCamera {
    if (!_stillCamera) {
        _stillCamera = [[GPUImageStillCamera alloc] initWithSessionPreset:AVCaptureSessionPresetHigh cameraPosition:(AVCaptureDevicePositionFront)];
        _stillCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
        _stillCamera.horizontallyMirrorFrontFacingCamera = YES;
        _stillCamera.delegate = self;
    }
    return _stillCamera;
}

@end
