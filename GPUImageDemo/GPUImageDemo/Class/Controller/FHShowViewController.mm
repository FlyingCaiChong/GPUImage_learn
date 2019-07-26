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

#define testFacepp 0

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"

@implementation FHShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak __typeof(self) weakSelf = self;
    [self checkFaceServiceBlock:^(BOOL results) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        strongSelf.faceServiceEnable = results;
        if (results) {
            [self configFaceMarkManager];
        }
    }];
    
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
        
        [self imageRender];
    } else {
        [self.navigationController.navigationBar setHidden:YES];
        [self configTimeDisplay];
        [self cameraRender];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.type == ShowTypeCamera) {
        [self.navigationController.navigationBar setHidden:NO];
    }
    
    if (self.displayLink) {
        [self.displayLink invalidate];
    }
}

- (BOOL)prefersStatusBarHidden {
    if (self.type == ShowTypeCamera) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - Face++
- (void)checkFaceServiceBlock:(void(^)(BOOL results))block{
    
    /** 进行联网授权版本判断，联网授权就需要进行网络授权 */
    BOOL needLicense = [MGFaceLicenseHandle getNeedNetLicense];
    if (needLicense) {
        [MGFaceLicenseHandle licenseForNetwokrFinish:^(bool License, NSDate *sdkDate) {
            if (!License) {
                NSLog(@"联网授权失败 ！！！");
                if (block) {
                    block(NO);
                }
            } else {
                NSLog(@"联网授权成功");
                if (block) {
                    block(YES);
                }
            }
        }];
        
    } else {
        NSLog(@"SDK 为非联网授权版本！");
        if (block) {
            block(NO);
        }
    }
}

- (void)configFaceMarkManager{
    
    NSString *modelPath = [[NSBundle mainBundle] pathForResource:KMGFACEMODELNAME ofType:@""];
    NSData *modelData = [NSData dataWithContentsOfFile:modelPath];
    
    int maxFaceCount = 0;
    int faceSize = 100;
    int internal = 40;
    
    MGDetectROI detectROI = MGDetectROIMake(0, 0, 0, 0);
    
    self.markManager = [[MGFacepp alloc] initWithModel:modelData
                                          maxFaceCount:maxFaceCount
                                         faceppSetting:^(MGFaceppConfig *config) {
                                             config.minFaceSize = faceSize;
                                             config.interval = internal;
                                             config.orientation = 90;
                                             config.detectionMode = MGFppDetectionModeTrackingFast;
                                             config.detectROI = detectROI;
                                             config.pixelFormatType = PixelFormatTypeRGBA;
                                         }];
    
}

- (void)testFaceppDetectSampleBuffer:(CMSampleBufferRef)sampleBuffer {
    
    MGImageData *imageData = [[MGImageData alloc] initWithSampleBuffer:sampleBuffer];
    
    [self.markManager beginDetectionFrame];
    
    NSArray *tempArray = [self.markManager detectWithImageData:imageData];
    NSUInteger faceCount = tempArray.count;
    NSLog(@"faceCount: %zd", faceCount);
    
    for (MGFaceInfo *faceInfo in tempArray) {
        [self.markManager GetGetLandmark:faceInfo isSmooth:YES pointsNumber:106];
        NSLog(@"landmark - %@", faceInfo.points);
        if ([self.imageFilter isKindOfClass:[GPUImageCustomLandmarkFilter class]]) {
            NSArray *pointsArr = faceInfo.points;
            int count = (int)(pointsArr.count * 2);
            GLfloat points[count];
            
            for (int i = 0; i < pointsArr.count; i++) {
                NSValue *pointValue = pointsArr[i];
                CGPoint point = [pointValue CGPointValue];
                points[2 * i + 1] = point.x/(imageData.width * 1.0);
                points[2 * i] = point.y/(imageData.height * 1.0);
            }
            
            GPUImageCustomLandmarkFilter *filter = (GPUImageCustomLandmarkFilter *)self.imageFilter;
            [filter renderCrosshairsFromArray:points count:pointsArr.count];
        }
    }
    
    [self.markManager endDetectionFrame];
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

- (void)imageRender {
    
    UIImage *tempImage = [UIImage imageNamed:kImageNamed];
    
    if ([self.imageFilter isKindOfClass:[GPUImageCustomMaskFilter class]]) {
        [self handleDetectResultForMaskFilter:tempImage];
    }
    else if ([self.imageFilter isKindOfClass:[GPUImageCustomFeaturePointsFilter class]]) {
        [self handleDetectResultForFeaturePointsFilter:tempImage];
    }
    else if ([self.imageFilter isKindOfClass:[GPUImageCustomLandmarkFilter class]]) {
        [self handleDetectResultForLandmarkFilter:tempImage];
    }
    else if ([self.imageFilter isKindOfClass:[GPUImageCustomAddPointsFilter class]]) {
        [self handleDetectResultForAddPointsFilter:tempImage];
    }
    else if ([self.imageFilter isKindOfClass:[GPUImageCustomFaceChangeFilter class]]) {
        [self handleDetectResultForFaceChangeFilter:tempImage];
    }
    else if ([self.imageFilter isKindOfClass:[GPUImageCustomFaceChangeGroup class]]) {
        [self handleDetectResultForFaceChangeGroup:tempImage];
    }
    
    [self render];
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

#pragma mark - GPUImageVideoCameraDelegate
- (void)willOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer {
    
    if (self.faceServiceEnable && testFacepp) {
        [self testFaceppDetectSampleBuffer:sampleBuffer];
    }
    
    if (![self needHandleDetectResult]) {
        return;
    }
    
    [self detectBrightnessWithSampleBuffer:sampleBuffer];
    
    CMSampleBufferRef picCopy; // 避免内存问题产生，此处Copy一份Buffer用作处理；
    CMSampleBufferCreateCopy(CFAllocatorGetDefault(), sampleBuffer, &picCopy);
    UIImage *tempImage = [UIImage imageFromSampleBuffer:(__bridge CMSampleBufferRef)(CFBridgingRelease(picCopy))];
    
    if ([self.imageFilter isKindOfClass:[GPUImageCustomMaskFilter class]]) {
        [self handleDetectResultForMaskFilter:tempImage];
    }
    
    else if ([self.imageFilter isKindOfClass:[GPUImageCustomFeaturePointsFilter class]]) {
        [self handleDetectResultForFeaturePointsFilter:tempImage];
    }
    
    else if ([self.imageFilter isKindOfClass:[GPUImageCustomLandmarkFilter class]]) {
        [self handleDetectResultForLandmarkFilter:tempImage];
    }
    
    else if ([self.imageFilter isKindOfClass:[GPUImageCustomAddPointsFilter class]]) {
        [self handleDetectResultForAddPointsFilter:tempImage];
    }
    
    else if ([self.imageFilter isKindOfClass:[GPUImageCustomFaceChangeFilter class]]) {
        [self handleDetectResultForFaceChangeFilter:tempImage];
    }
    else if ([self.imageFilter isKindOfClass:[GPUImageCustomFaceChangeGroup class]]) {
        [self handleDetectResultForFaceChangeGroup:tempImage];
    }
}

- (void)detectBrightnessWithSampleBuffer:(CMSampleBufferRef)sampleBuffer {
    
    CFDictionaryRef metadataDict = CMCopyDictionaryOfAttachments(NULL, sampleBuffer, kCMAttachmentMode_ShouldPropagate);
    NSDictionary *metadata =  [[NSMutableDictionary alloc] initWithDictionary:(__bridge NSDictionary *)metadataDict];
    CFRelease(metadataDict);
    NSDictionary *exifMetadata = [[metadata objectForKey:(NSString *)kCGImagePropertyExifDictionary] mutableCopy];
    float brightnessValue = [[exifMetadata objectForKey:(NSString *)kCGImagePropertyExifBrightnessValue] floatValue];
    NSLog(@"brightness: %f", brightnessValue);
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
        _stillCamera.delegate = self;
    }
    return _stillCamera;
}

- (SXSenseDetectTool *)detectTool {
    if (!_detectTool) {
        _detectTool = [SXSenseDetectTool sharedInstance];
    }
    return _detectTool;
}

@end
#pragma clang diagnostic pop


