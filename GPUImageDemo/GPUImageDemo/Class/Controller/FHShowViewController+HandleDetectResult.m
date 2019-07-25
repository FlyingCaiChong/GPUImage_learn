//
//  FHShowViewController+HandleDetectResult.m
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/17.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import "FHShowViewController+HandleDetectResult.h"
#import "FHShowViewController+Private.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
#pragma clang diagnostic ignored "-Wundeclared-selector"

@implementation FHShowViewController (HandleDetectResult)

- (BOOL)needHandleDetectResult {
    NSArray *arr = @[
                     NSStringFromClass([GPUImageCustomMaskFilter class]),
                     NSStringFromClass([GPUImageCustomFeaturePointsFilter class]),
                     NSStringFromClass([GPUImageCustomLandmarkFilter class]),
                     NSStringFromClass([GPUImageCustomAddPointsFilter class]),
                     NSStringFromClass([GPUImageCustomFaceChangeFilter class]),
                     ];
    
    NSString *filterTitle = NSStringFromClass([self.imageFilter class]);
    return [arr containsObject:filterTitle];
}

- (void)handleDetectResultForMaskFilter:(UIImage *)image {
    if (![self.imageFilter isKindOfClass:[GPUImageCustomMaskFilter class]]) {
        return;
    }

    // 获取原图宽度
    int imageWidth = (int)CGImageGetWidth(image.CGImage);
    // 获取原图高度
    int imageHeight = (int)CGImageGetHeight(image.CGImage);
    
    int *faces = [self.detectTool testFacesForImage:image];
    
    if (faces == NULL) {
        return;
    }
    
    int faceNum = faces[0];
    if (faceNum != 1) {
        return;
    }
    
    int left = faces[1];
    int top = faces[2];
    int right = faces[3];
    int bottom = faces[4];
    
    NSLog(@"left: %d, top: %d, right: %d, bottom: %d, width: %d, height: %d", left, top, right, bottom, imageWidth, imageHeight);
    
    CGFloat originX = left / (imageWidth * 1.0);
    CGFloat originY = top / (imageHeight * 1.0);
    
    CGFloat originW = (right - left) / (imageWidth * 1.0);
    CGFloat originH = (bottom - top) / (imageHeight * 1.0);
    CGRect mask = CGRectMake(originX, originY, originW, originH);
    
    NSLog(@"x: %f, y: %f, w: %f, h: %f", originX, originY, originW, originH);
    NSLog(@"mask: %@", [NSValue valueWithCGRect:mask]);
    
    GPUImageCustomMaskFilter *maskFilter = (GPUImageCustomMaskFilter *)self.imageFilter;
    
    maskFilter.mask = mask;
}

- (void)handleDetectResultForFeaturePointsFilter:(UIImage *)image {
    if (![self.imageFilter isKindOfClass:[GPUImageCustomFeaturePointsFilter class]]) {
        return;
    }
    // 获取原图宽度
    int imageWidth = (int)CGImageGetWidth(image.CGImage);
    // 获取原图高度
    int imageHeight = (int)CGImageGetHeight(image.CGImage);
    
    int *faces = [self.detectTool testFacesForImage:image];
    
    if (faces == NULL) {
        return;
    }
    
    int faceNum = faces[0];
    if (faceNum != 1) {
        return;
    }
    
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
    GPUImageCustomFeaturePointsFilter *filter = (GPUImageCustomFeaturePointsFilter *)self.imageFilter;
    [filter setFloatArray:points length:count];
}

- (void)handleDetectResultForLandmarkFilter:(UIImage *)image {
    if (![self.imageFilter isKindOfClass:[GPUImageCustomLandmarkFilter class]]) {
        return;
    }
    
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
    
    GPUImageCustomLandmarkFilter *filter = (GPUImageCustomLandmarkFilter *)self.imageFilter;
    [filter renderCrosshairsFromArray:points count:pointsArr.count];
}

- (void)handleDetectResultForAddPointsFilter:(UIImage *)image {
    if (![self.imageFilter isKindOfClass:[GPUImageCustomAddPointsFilter class]]) {
        return;
    }
    
    // 获取原图宽度
    int imageWidth = (int)CGImageGetWidth(image.CGImage);
    // 获取原图高度
    int imageHeight = (int)CGImageGetHeight(image.CGImage);
    
    NSArray *pointsArr = [[self.detectTool resultForDetectWithImage:image] copy];
//    NSLog(@"pointArr: %@", pointsArr);
    int count = (int)(pointsArr.count * 2);
    GLfloat points[count];
    
    for (int i = 0; i < pointsArr.count; i++) {
        NSValue *pointValue = pointsArr[i];
        CGPoint point = [pointValue CGPointValue];
        points[2 * i] = point.x/(imageWidth * 1.0);
        points[2 * i + 1] = point.y/(imageHeight * 1.0);
    }
    
    GPUImageCustomAddPointsFilter *filter = (GPUImageCustomAddPointsFilter *)self.imageFilter;
    [filter renderPointsFromArray:points count:pointsArr.count];
}

- (void)handleDetectResultForFaceChangeFilter:(UIImage *)image {
    if (![self.imageFilter isKindOfClass:[GPUImageCustomFaceChangeFilter class]]) {
        return;
    }
    
    // 获取原图宽度
    int imageWidth = (int)CGImageGetWidth(image.CGImage);
    // 获取原图高度
    int imageHeight = (int)CGImageGetHeight(image.CGImage);
    
    NSArray *pointsArray = [[self.detectTool resultForDetectWithImage:image] copy];
    
    GPUImageCustomFaceChangeFilter *filter = (GPUImageCustomFaceChangeFilter *)self.imageFilter;
    filter.isHaveFace = YES;
    [filter setFacePointArray:pointsArray width:imageWidth height:imageHeight];
}

@end

#pragma clang diagnostic pop
