//
//  FHMathTool.h
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/17.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FHMathTool : NSObject

+ (NSArray *)getRectByPoints:(NSArray *)points;

/**
 将嘴唇区域内的坐标点数据加到列表中
 */
+ (void)addPointY1:(CGFloat)y1
                y2:(CGFloat)y2
                 x:(NSInteger)x
             xList:(NSMutableArray *)xList
             yList:(NSMutableArray *)yList;


/**
 根据二次插值函数计算出x对应的y值
 */
+ (CGFloat)getPointYByABCWithX:(CGFloat)x
                           abc:(NSArray *)abc;

/**
 获取二次插值函数的各项系数
 */
+ (NSArray *)getABCWithPoints:(NSArray *)points;

/**
 根据三次插值函数计算出x对应的y值
 */
+ (CGFloat)getPointYByABCDWithX:(CGFloat)x
                           abcd:(NSArray *)abcd;


/**
 获取三次插值函数的各项系数
 */
+ (NSArray *)getABCDWithPoints:(NSArray *)points;

@end

NS_ASSUME_NONNULL_END
