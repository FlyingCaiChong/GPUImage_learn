//
//  FetchCategoryFiltersTool.h
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/9.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FHFetchCategoryFiltersTool : NSObject

#pragma mark - GPUImage filters category
+ (NSArray *)colorAdjustmentsFilters;
+ (NSArray *)imageProcessingFilters;
+ (NSArray *)blendingModesFilters;
+ (NSArray *)visualEffectsFilters;

#pragma mark - Custom Fitlers
+ (NSArray *)customFilters;

@end

NS_ASSUME_NONNULL_END
