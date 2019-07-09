//
//  FetchCategoryFiltersTool.h
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/9.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FetchCategoryFiltersTool : NSObject

+ (NSArray *)colorAdjustmentsFilters;
+ (NSArray *)imageProcessingFilters;
+ (NSArray *)blendingModesFilters;
+ (NSArray *)visualEffectsFilters;

@end

NS_ASSUME_NONNULL_END
