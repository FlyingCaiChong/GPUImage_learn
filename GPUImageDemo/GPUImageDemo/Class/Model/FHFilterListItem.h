//
//  FilterListItem.h
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/9.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FHFilterListItem : NSObject

// 滤镜名称
@property (nonatomic, strong) NSString *title;
// 滤镜详细描述
@property (nonatomic, strong) NSString *desc;
// 滤镜所继承的类
@property (nonatomic, strong) NSString *inherit;
// 属性参数个数
@property (nonatomic, strong) NSNumber *parametersNum;
// 翻译
@property (nonatomic, strong) NSString *translate;

@end

NS_ASSUME_NONNULL_END
