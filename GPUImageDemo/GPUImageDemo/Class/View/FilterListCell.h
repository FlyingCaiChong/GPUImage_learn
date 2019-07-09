//
//  FilterListCell.h
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/9.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FilterListCell : UITableViewCell

- (void)configTitle:(NSString *)title;
- (void)configDesc:(NSString *)desc;
- (void)configInherit:(NSString *)input;

+ (NSString *)cellIdentifier;

@end

NS_ASSUME_NONNULL_END
