//
//  SXSenseDetectTool.m
//  AphroditeApp
//
//  Created by iOS_Developer on 2019/2/21.
//  Copyright © 2019年 iOSDev. All rights reserved.
//
#import "mtcnn.h"
#import "landmark.h"
#import "SXSenseDetectTool.h"
#import "UIImage+SXExtension.h"


@interface SXSenseDetectTool ()
{
    MTCNN *mtcnn;
    Landmark *landmark;
}

@end

static SXSenseDetectTool *instance = nil;
@implementation SXSenseDetectTool

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SXSenseDetectTool alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self p_initMTCNN];
        [self p_initLandmark];
    }
    return self;
}

- (void)p_initMTCNN {
    
    mtcnn = MTCNN::getInstance();
    const char* destDir = [[NSBundle mainBundle].bundlePath UTF8String];
    bool init_ok = mtcnn->init(destDir);
    if (init_ok) {
        NSLog(@"MTCNN init success");
    } else {
        NSLog(@"MTCNN init failure");
    }
}

- (void)p_initLandmark {
    
    landmark = Landmark::getInstance();
    const char* destDir = [[NSBundle mainBundle].bundlePath UTF8String];
    bool landmarkInit_ok = landmark->init(destDir);
    
    if (landmarkInit_ok) {
        NSLog(@"Landmark init success");
        landmark->setNumThreads(4);
        landmark->setParam(112, 112, 127);
    } else {
        NSLog(@"Landmark init failure");
    }
}

// 使用算法模型人脸识别获取人脸数目
- (int)facesNumWithImage:(UIImage *)image {
    UIImage *fixedImage = [image sx_fixOrientation];
    
    unsigned char *imageData = [UIImage convertUIImageToBitmapRGBA8:fixedImage];
    // 获取原图宽度
    int imageWidth = (int)CGImageGetWidth(fixedImage.CGImage);
    
    // 获取原图高度
    int imageHeight = (int)CGImageGetHeight(fixedImage.CGImage);
    
    // 通道
    int imageChannel = 4;
    
    // 检测人脸, 人脸数量和位置返回在数组指针里
    int *faces = mtcnn->faceDetect(imageData, imageWidth, imageHeight, imageChannel);
    if (faces == nullptr) {
        return 0;
    }
    // 检测到的人脸数量
    int facesNum = faces[0];

    return facesNum;
}

- (int *)testFacesForImage:(UIImage *)image {
    UIImage *fixedImage = [image sx_fixOrientation];
    
    unsigned char *imageData = [UIImage convertUIImageToBitmapRGBA8:fixedImage];
//    printf("\n------------------\n");
//    for (int i = 1000; i < 1200; i++) {
//        printf(" %d", imageData[i]);
//    }
//    printf("\n------------------\n");
    // 获取原图宽度
    int imageWidth = (int)CGImageGetWidth(fixedImage.CGImage);
    
    // 获取原图高度
    int imageHeight = (int)CGImageGetHeight(fixedImage.CGImage);
    
    // 通道
    int imageChannel = 4;
    // 检测人脸, 人脸数量和位置返回在数组指针里
    int *faces = mtcnn->faceDetect(imageData, imageWidth, imageHeight, imageChannel);
    
    free(imageData);
    
    return faces;
}

- (NSDictionary *)resultForDetectWithImage:(UIImage *)image {
    
    UIImage *fixedImage = [image sx_fixOrientation];
    
    unsigned char *imageData = [UIImage convertUIImageToBitmapRGBA8:fixedImage];
    
    // 获取原图宽度
    int imageWidth = (int)CGImageGetWidth(fixedImage.CGImage);
    
    // 获取原图高度
    int imageHeight = (int)CGImageGetHeight(fixedImage.CGImage);
    
    // 通道
    int imageChannel = 4;
    
    // 检测人脸, 人脸数量和位置返回在数组指针里
    int *faces = mtcnn->faceDetect(imageData, imageWidth, imageHeight, imageChannel);
    if (faces == nullptr) {
        return nil;
    }
    // 检测到的人脸数量
    int facesNum = faces[0];
    
    if (facesNum != 1) {
        return nil;
    }
    
    int left = faces[1];
    int top = faces[2];
    int right = faces[3];
    int bottom = faces[4];
    
    // 检测特征点
    int *points = landmark->detectSE(imageData, imageWidth, imageHeight, imageChannel, left, top, right, bottom);
    if (points == nullptr) {
        return nil;
    }
    
    // 增加五官特征点数组
    NSMutableArray *pointArr = [NSMutableArray array];
    int numPoint = 127;
//    printf("\n--------------\n");
    for (int p = 0; p < numPoint * 2; p = p+2) {
        CGPoint point = CGPointMake(points[p], points[p+1]);
        NSValue *pointValue = [NSValue valueWithCGPoint:point];
        [pointArr addObject:pointValue];
//        printf("%d,%d\t", points[p], points[p+1]);
    }
//    printf("\n---------------\n");
    
    return nil;
}

@end
