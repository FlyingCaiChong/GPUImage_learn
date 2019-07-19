//
//  FHMakeupViewController.m
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/16.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import "FHLipstickViewController.h"
#import "GPUImage.h"
#import "SXSenseDetectTool.h"
#import "UIImage+SXExtension.h"
#import "GPUImageCustomLipstickGenerator.h"
#import "FHMathTool.h"

/*
 FIXME: --------
 存在以下问题待解决:
 1. 刚进来时如果没有人脸时，会出现白屏问题
 2. 有人脸之后正常，但人脸移出屏幕外时，内存泄露
 3. 贴妆位置需优化
 */

@interface FHLipstickViewController ()<GPUImageVideoCameraDelegate>
{
    CGFloat r;
    CGFloat g;
    CGFloat b;
    NSMutableArray *xList;
    NSMutableArray *yList;
    CGFloat offsetColorR;
    CGFloat offsetColorG;
    CGFloat offsetColorB;
    CGFloat texelWidthOffset;
    CGFloat texelHeightOffset;
    NSMutableArray *lipstickArr;
    NSArray *lipstickIndexArr;
    NSMutableArray *o_u_l_points;
    NSMutableArray *o_u_r_points;
    NSMutableArray *o_l_points;
    NSMutableArray *i_u_l_points;
    NSMutableArray *i_u_r_points;
    NSMutableArray *i_l_points;
    NSArray *o_u_l_f;
    NSArray *o_u_r_f;
    NSArray *o_l_f;
    NSArray *i_u_l_f;
    NSArray *i_u_r_f;
    NSArray *i_l_f;
}
@property (nonatomic, strong) GPUImagePicture *imagePicture;
@property (nonatomic, strong) GPUImageAlphaBlendFilter *alphaBlendFilter;
@property (nonatomic, strong) GPUImageCustomLipstickGenerator *lipstickGenerator;
@property (nonatomic, strong) GPUImageView *videoImageView;
@property (nonatomic, strong) UIImageView *showImageView;
@property (nonatomic, strong) SXSenseDetectTool *detectTool;
@property (nonatomic, strong) GPUImageStillCamera *stillCamera;

@end

@implementation FHLipstickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    r = 255; g = 0; b = 0;
    xList = [NSMutableArray array];
    yList = [NSMutableArray array];
    lipstickArr = [NSMutableArray arrayWithCapacity:20];
    lipstickIndexArr = @[@48, @49, @51, @53, @54, @56, @58, @60, @61, @62, @63, @64, @65, @67];
    o_u_l_points = [NSMutableArray arrayWithCapacity:6];
    o_u_r_points = [NSMutableArray arrayWithCapacity:6];
    o_l_points = [NSMutableArray arrayWithCapacity:8];
    i_u_l_points = [NSMutableArray arrayWithCapacity:6];
    i_u_r_points = [NSMutableArray arrayWithCapacity:6];
    i_l_points = [NSMutableArray arrayWithCapacity:8];
    
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
    self.lipstickGenerator = [[GPUImageCustomLipstickGenerator alloc] init];
    
    self.alphaBlendFilter = [[GPUImageAlphaBlendFilter alloc] init];
    [self.imagePicture addTarget:self.alphaBlendFilter];
    [self.lipstickGenerator addTarget:self.alphaBlendFilter];
    [self.alphaBlendFilter useNextFrameForImageCapture];
    
    UIImage *image = [UIImage imageNamed:@"img_test"];
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
    
    [self handleLipstickWithPointsArr:pointsArr width:imageWidth height:imageHeight image:image];
    
    [self.imagePicture processImage];
    
    self.showImageView.image = [self.alphaBlendFilter imageFromCurrentFramebuffer];
}

- (void)handleLipstickWithPointsArr:(NSArray *)pointsArr width:(int)width height:(int)height image:(UIImage *)image {
    
    [lipstickArr removeAllObjects];
    [o_u_l_points removeAllObjects];
    [o_u_r_points removeAllObjects];
    [o_l_points removeAllObjects];
    [i_u_l_points removeAllObjects];
    [i_u_r_points removeAllObjects];
    [i_l_points removeAllObjects];
    
    // 1. 取到唇部特征点
    for (int i = 0; i < pointsArr.count; i++) {
        if ([lipstickIndexArr containsObject:@(i)]) {
            NSValue *pointValue = pointsArr[i];
            CGPoint point = [pointValue CGPointValue];
            [lipstickArr addObject:@(point.x)];
            [lipstickArr addObject:@(point.y)];
        }
    }
    
    [o_u_l_points addObjectsFromArray:[lipstickArr subarrayWithRange:NSMakeRange(0, 6)]];
    [o_u_r_points addObjectsFromArray:[lipstickArr subarrayWithRange:NSMakeRange(4, 6)]];
    [o_l_points addObject:lipstickArr[0]];
    [o_l_points addObject:lipstickArr[1]];
    [o_l_points addObjectsFromArray:[lipstickArr subarrayWithRange:NSMakeRange(8, 6)]];
    [i_u_l_points addObjectsFromArray:[lipstickArr subarrayWithRange:NSMakeRange(14, 6)]];
    [i_u_r_points addObjectsFromArray:[lipstickArr subarrayWithRange:NSMakeRange(18, 6)]];
    [i_l_points addObject:lipstickArr[14]];
    [i_l_points addObject:lipstickArr[15]];
    [i_l_points addObjectsFromArray:[lipstickArr subarrayWithRange:NSMakeRange(22, 6)]];
    
    o_u_l_f = [FHMathTool getABCWithPoints:o_u_l_points];
    o_u_r_f = [FHMathTool getABCWithPoints:o_u_r_points];
    o_l_f = [FHMathTool getABCDWithPoints:o_l_points];
    i_u_l_f = [FHMathTool getABCWithPoints:i_u_l_points];
    i_u_r_f = [FHMathTool getABCWithPoints:i_u_r_points];
    i_l_f = [FHMathTool getABCDWithPoints:i_l_points];
    
    [xList removeAllObjects];
    [yList removeAllObjects];
    
    for (int i = [o_u_l_points[0] intValue]; i < [i_u_l_points[0] intValue] + 1; i++) {
        double y1 = [FHMathTool getPointYByABCWithX:i abc:o_u_l_f];
        double y2 = [FHMathTool getPointYByABCDWithX:i abcd:o_l_f] + 1;
        [FHMathTool addPointY1:y1 y2:y2 x:i xList:xList yList:yList];
    }
    
    for (int i = [i_u_l_points[0] intValue]; i < [o_u_l_points[4] intValue] + 1; i++) {
        double y1 = [FHMathTool getPointYByABCWithX:i abc:o_u_l_f];
        double y2 = [FHMathTool getPointYByABCWithX:i abc:i_u_l_f] + 1;
        [FHMathTool addPointY1:y1 y2:y2 x:i xList:xList yList:yList];
        double y3 = [FHMathTool getPointYByABCDWithX:i abcd:i_l_f];
        double y4 = [FHMathTool getPointYByABCDWithX:i abcd:o_l_f] + 1;
        [FHMathTool addPointY1:y3 y2:y4 x:i xList:xList yList:yList];
    }
    
    for (int i = [i_u_r_points[4] intValue]; i < [o_u_r_points[4] intValue] + 1; i++) {
        double y1 = [FHMathTool getPointYByABCWithX:i abc:o_u_r_f];
        double y2 = [FHMathTool getPointYByABCDWithX:i abcd:o_l_f] + 1;
        [FHMathTool addPointY1:y1 y2:y2 x:i xList:xList yList:yList];
    }
    
    for (int i = [i_u_r_points[0] intValue]; i < [i_u_r_points[4] intValue] + 1; i++) {
        double y1 = [FHMathTool getPointYByABCWithX:i abc:o_u_r_f];
        double y2 = [FHMathTool getPointYByABCWithX:i abc:i_u_r_f] + 1;
        [FHMathTool addPointY1:y1 y2:y2 x:i xList:xList yList:yList];
        double y3 = [FHMathTool getPointYByABCDWithX:i abcd:i_l_f];
        double y4 = [FHMathTool getPointYByABCDWithX:i abcd:o_l_f] + 1;
        [FHMathTool addPointY1:y3 y2:y4 x:i xList:xList yList:yList];
    }
    
    GLfloat mVertices[xList.count * 2];
    for (int i = 0; i < xList.count; i++) {
        mVertices[2 * i] = 2 * [yList[i] intValue] * 1.0 / width - 1;
        mVertices[2 * i + 1] = 2 * ([xList[i] intValue]) * 1.0 / height - 1;
    }
    
    float sum_r = 0;
    float sum_g = 0;
    float sum_b = 0;
    
    unsigned char *data = [UIImage convertUIImageToBitmapRGBA8:image];
    size_t bytesPerRow = [UIImage bytesPerRowForImage:image];
    
    for (int i = 0; i < xList.count; i++) {
        @autoreleasepool {
            CGPoint point = CGPointMake([yList[i] intValue], [xList[i] intValue]);
            if (point.y > height || point.y < 0) {
                break;
            }
            if (point.x > width || point.x < 0) {
                break;
            }
            NSArray *rgb = [UIImage pointColorWithImageData:data point:point bytesPerRow:bytesPerRow];
            sum_r += [rgb[0] floatValue];
            sum_g += [rgb[1] floatValue];
            sum_b += [rgb[2] floatValue];
        }
    }
    
    float avg_r = sum_r / xList.count;
    float avg_g = sum_g / xList.count;
    float avg_b = sum_b / xList.count;
    
    offsetColorR = (r - avg_r) * 1.0 / 255;
    offsetColorG = (g - avg_g) * 1.0 / 255;
    offsetColorB = (b - avg_b) * 1.0 / 255;
    
    texelWidthOffset = 1.0 / width;
    texelHeightOffset = 1.0 / height;
    
    [self.lipstickGenerator forceProcessingAtSize:CGSizeMake(width, height)];
    self.lipstickGenerator.texelWidthOffset = texelWidthOffset;
    self.lipstickGenerator.texelHeightOffset = texelHeightOffset;
    [self.lipstickGenerator setColorRed:offsetColorR green:offsetColorG blue:offsetColorB];
    free(data);
    CMTime frameTime = CMTimeMake(0, 1);
    [self.lipstickGenerator renderLipstickFromArray:mVertices count:xList.count frameTime:frameTime];
}

- (void)setupCameraFilter {
    self.lipstickGenerator = [[GPUImageCustomLipstickGenerator alloc] init];
    self.alphaBlendFilter = [[GPUImageAlphaBlendFilter alloc] init];
    [self.stillCamera addTarget:self.alphaBlendFilter];
    [self.lipstickGenerator addTarget:self.alphaBlendFilter];
    [self.lipstickGenerator forceProcessingAtSize:CGSizeMake(720, 1280)];
    [self.alphaBlendFilter addTarget:self.videoImageView];
}

- (void)cameraRender {
    [self.stillCamera startCameraCapture];
}


#pragma mark - GPUImageVideoCameraDelegate
- (void)willOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer {
    CMSampleBufferRef picCopy; // 避免内存问题产生，此处Copy一份Buffer用作处理；
    CMSampleBufferCreateCopy(CFAllocatorGetDefault(), sampleBuffer, &picCopy);
    UIImage *tempImage = [UIImage imageFromSampleBuffer:(__bridge CMSampleBufferRef)(CFBridgingRelease(picCopy))];
    // 获取原图宽度
    int imageWidth = (int)CGImageGetWidth(tempImage.CGImage);
    // 获取原图高度
    int imageHeight = (int)CGImageGetHeight(tempImage.CGImage);
    
    NSArray *pointsArr = [[self.detectTool resultForDetectWithImage:tempImage] copy];
    
    if (nil == pointsArr) {
        return;
    }
    
    
    int count = (int)(pointsArr.count * 2);
    GLfloat points[count];
    
    for (int i = 0; i < pointsArr.count; i++) {
        NSValue *pointValue = pointsArr[i];
        CGPoint point = [pointValue CGPointValue];
        points[2 * i] = point.x/(imageWidth * 1.0);
        points[2 * i + 1] = point.y/(imageHeight * 1.0);
    }
    
    
    [self handleLipstickWithPointsArr:pointsArr width:imageWidth height:imageHeight image:tempImage];
    
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
