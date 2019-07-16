//
//  UIImage+SXExtension.h
//  AphroditeApp
//
//  Created by iOSDev on 2018/9/3.
//  Copyright © 2018年 iOSDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMedia/CoreMedia.h>

@interface UIImage (SXExtension)

+ (UIImage *)thumbnailWithImage:(UIImage *)image size:(CGSize)asize;

/**
 *  生成图片
 *
 *  @param color  图片颜色
 *  @param height 图片高度
 *
 *  @return 生成的图片
 */
+ (UIImage*)getImageWithColor:(UIColor*)color andHeight:(CGFloat)height;


/**
 生成相应圆角image

 @param radius 圆角度
 @return image
 */
- (UIImage *)imageWithCornerRadius:(CGFloat)radius;


/**
 根据遮罩图生成相应image

 @param maskImage 遮罩图
 @return image
 */
- (UIImage *)imageWithMask:(UIImage *)maskImage;


/**
 根据url获取图片的尺寸

 @param URL 图片url
 @return 图片尺寸
 */
+ (CGSize)getImageSizeWithURL:(id)URL;

/**
 根据url生成CIImage二维码
 @see https://github.com/KeenTeam1990/SGQRCode/blob/master/SGQRCode/SGQRCodeGenerateManager.m
 @param urlStr url
 @return 二维码
 */
+ (CIImage *)createCIImageWithQRCodeUrlStr:(NSString *)urlStr;


/**
 根据CIImage生成指定大小的UIImage

 @param image CIImage
 @param size 图片宽度
 @return 二维码
 */
+ (UIImage *)createNonInterpolatedUIImageFromCIImage:(CIImage *)image withSize:(CGFloat)size;


/**
 根据view生成图片

 @param view 视图
 @return 图片
 */
+ (UIImage *)createImageWithView:(UIView *)view;

#pragma mark - Introduction
+ (UIImage *)sx_setAnimatedGIFWithGifName:(NSString *)name;
+ (UIImage *)sx_setAnimatedGIFWithData:(NSData *)data;

+ (float)sx_setFrameDurationAtIndex:(NSUInteger)index source:(CGImageSourceRef)source;


// 将图片裁剪成指定Size 打分时需要裁剪成128*128
- (UIImage *)imageCompressFortargetSize:(CGSize)size;


/**
 修正UIImage的Orientation属性.
 @see https://www.jianshu.com/p/df094c044096
 */
- (UIImage *)sx_fixOrientation;

// 将视频流帧数据转为图片
+ (UIImage *)imageFromSampleBuffer:(CMSampleBufferRef)sampleBuffer;

+ (unsigned char *)convertUIImageToBitmapRGBA8:(UIImage *)image;

@end
