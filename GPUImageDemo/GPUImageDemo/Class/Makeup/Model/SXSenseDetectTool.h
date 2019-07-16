//
//  SXSenseDetectTool.h
//  AphroditeApp
//
//  Created by iOS_Developer on 2019/2/21.
//  Copyright © 2019年 iOSDev. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * 五官检测工具
 */
@interface SXSenseDetectTool : NSObject

+ (instancetype)sharedInstance;

// 检测人脸五官结果
- (NSMutableArray *)resultForDetectWithImage:(UIImage *)image;

// 使用算法模型人脸识别获取人脸数目
- (int)facesNumWithImage:(UIImage *)image;

// 测试使用
- (int *)testFacesForImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
