//
//  UIImage+SXExtension.m
//  AphroditeApp
//
//  Created by iOSDev on 2018/9/3.
//  Copyright © 2018年 iOSDev. All rights reserved.
//

#import "UIImage+SXExtension.h"
#import <ImageIO/ImageIO.h>

@implementation UIImage (SXExtension)

+ (UIImage *)thumbnailWithImage:(UIImage *)image size:(CGSize)asize{
    UIImage *newimage;
    if (nil == image) {
        newimage = nil;
    }
    else{
        CGSize oldsize = image.size;
        CGRect rect;
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            rect.size.height = asize.height;
            rect.origin.x = (asize.width - rect.size.width)/2;
            rect.origin.y = 0;
        }
        else{
            rect.size.width = asize.width;
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            rect.origin.x = 0;
            rect.origin.y = (asize.height - rect.size.height)/2;
        }
        UIGraphicsBeginImageContext(asize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        [image drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newimage;
}

/**
 *  生成图片
 *
 *  @param color  图片颜色
 *  @param height 图片高度
 *
 *  @return 生成的图片
 */
+ (UIImage*)getImageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
    CGRect r= CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

- (UIImage *)imageWithCornerRadius:(CGFloat)radius
{
    //create drawing context
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //clip image
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0.0f, radius);
    CGContextAddLineToPoint(context, 0.0f, self.size.height - radius);
    CGContextAddArc(context, radius, self.size.height - radius, radius, M_PI, M_PI / 2.0f, 1);
    CGContextAddLineToPoint(context, self.size.width - radius, self.size.height);
    CGContextAddArc(context, self.size.width - radius, self.size.height - radius, radius, M_PI / 2.0f, 0.0f, 1);
    CGContextAddLineToPoint(context, self.size.width, radius);
    CGContextAddArc(context, self.size.width - radius, radius, radius, 0.0f, -M_PI / 2.0f, 1);
    CGContextAddLineToPoint(context, radius, 0.0f);
    CGContextAddArc(context, radius, radius, radius, -M_PI / 2.0f, M_PI, 1);
    CGContextClip(context);
    
    //draw image
    [self drawAtPoint:CGPointZero];
    
    //capture resultant image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //return image
    return image;
}


- (UIImage *)imageWithMask:(UIImage *)maskImage
{
    //create drawing context
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //apply mask
    CGContextClipToMask(context, CGRectMake(0.0f, 0.0f, self.size.width, self.size.height), maskImage.CGImage);
    
    //draw image
    [self drawAtPoint:CGPointZero];
    
    //capture resultant image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //return image
    return image;
}

+ (CGSize)getImageSizeWithURL:(id)URL {
    NSURL * url = nil;
    if ([URL isKindOfClass:[NSURL class]]) {
        url = URL;
    }
    if ([URL isKindOfClass:[NSString class]]) {
        url = [NSURL URLWithString:URL];
    }
    if (!URL) {
        return CGSizeZero;
    }
    CGImageSourceRef imageSourceRef = CGImageSourceCreateWithURL((CFURLRef)url, NULL);
    CGFloat width = 0, height = 0;
    if (imageSourceRef) {
        CFDictionaryRef imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSourceRef, 0, NULL);
        if (imageProperties != NULL) {
            CFNumberRef widthNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelWidth);
            #if defined(__LP64__) && __LP64__
            if (widthNumberRef != NULL) {
                CFNumberGetValue(widthNumberRef, kCFNumberFloat64Type, &width);
            }
            CFNumberRef heightNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
            if (heightNumberRef != NULL) {
                CFNumberGetValue(heightNumberRef, kCFNumberFloat64Type, &height);
            }
            #else
            if (widthNumberRef != NULL) {
                CFNumberGetValue(widthNumberRef, kCFNumberFloat32Type, &width);
            }
            CFNumberRef heightNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
            if (heightNumberRef != NULL) {
                CFNumberGetValue(heightNumberRef, kCFNumberFloat32Type, &height);
            }
            
            #endif
            CFRelease(imageProperties);
        }
        CFRelease(imageSourceRef);
    }
    return CGSizeMake(width, height);
}

+ (CIImage *)createCIImageWithQRCodeUrlStr:(NSString *)urlStr {
    
    // 创建过滤器
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 过滤器恢复默认
    [filter setDefaults];
    
    NSData *data = [urlStr dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    
    [filter setValue:data forKey:@"inputMessage"];
    
    // 获取二维码过滤器生成的二维码
    CIImage *image = [filter outputImage];
    
    return image;
}

+ (UIImage *)createNonInterpolatedUIImageFromCIImage:(CIImage *)image withSize:(CGFloat)size {
    
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1. 创建bitmap
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2. 保存bitmap图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

+ (UIImage *)createImageWithView:(UIView *)view {
    CGSize size = view.bounds.size;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - Introduction
+ (UIImage *)sx_setAnimatedGIFWithGifName:(NSString *)name {
    CGFloat xyScale = [UIScreen mainScreen].scale;
    if(xyScale >1.0f){
        NSString * retinaPath = [[NSBundle mainBundle] pathForResource:[name stringByAppendingString:@"@2x"] ofType:@"gif"];
        NSData * data = [NSData dataWithContentsOfFile:retinaPath];
        if(data){
            return [UIImage sx_setAnimatedGIFWithData:data];
        }
        NSString * path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        data = [NSData dataWithContentsOfFile:path];
        if(data){
            return [UIImage sx_setAnimatedGIFWithData:data];
        }
        return [UIImage imageNamed:name];
    }else{
        NSString * path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        NSData * data = [NSData dataWithContentsOfFile:path];
        if(data){
            return [UIImage sx_setAnimatedGIFWithData:data];
        }
        return [UIImage imageNamed:name];
    }
}

+ (UIImage *)sx_setAnimatedGIFWithData:(NSData *)data {
    if(!data){
        return nil;
    }
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    size_t count = CGImageSourceGetCount(source);
    UIImage * animatedImg;
    if(count <= 1){
        animatedImg = [[UIImage alloc]initWithData:data];
    }else{
        NSMutableArray * imgsArr = [NSMutableArray array];
        NSTimeInterval duration = 0.0f;
        for(size_t i = 0; i < count;i++){
            CGImageRef img = CGImageSourceCreateImageAtIndex(source, i, NULL);
            if(!img){
                continue;
            }
            duration += [self sx_setFrameDurationAtIndex:i source:source];
            [imgsArr addObject:[UIImage imageWithCGImage:img scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
            CGImageRelease(img);
        }
        if(!duration){
            duration = (1.0f/10.0f) * count;
        }
        animatedImg = [UIImage animatedImageWithImages:imgsArr duration:duration];
    }
    CFRelease(source);
    return animatedImg;
}

+ (float)sx_setFrameDurationAtIndex:(NSUInteger)index source:(CGImageSourceRef)source {
    float frameDuration = 0.1f;
    CFDictionaryRef cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil);
    NSDictionary * frameProperties = (__bridge NSDictionary *)cfFrameProperties;
    NSDictionary * gifProperties = frameProperties[(NSString *)kCGImagePropertyGIFDictionary];
    NSNumber * delayTimeUnclampedProp = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
    if(delayTimeUnclampedProp){
        frameDuration = [delayTimeUnclampedProp floatValue];
    }else{
        NSNumber * delayTimeProp = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
        if(delayTimeProp){
            frameDuration = [delayTimeProp floatValue];
        }
    }
    if(frameDuration < 0.011f){
        frameDuration = 0.100f;
    }
    CFRelease(cfFrameProperties);
    return frameDuration;
}


- (UIImage *)imageCompressFortargetSize:(CGSize)size {
    
    UIImage *newImage = nil;
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        } else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 3.0);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [self drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)sx_fixOrientation {
        
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

+ (UIImage *)imageFromSampleBuffer:(CMSampleBufferRef)sampleBuffer {
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    
    CVPixelBufferLockBaseAddress(imageBuffer, 0);
    
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    if (!colorSpace) {
        NSLog(@"CGColorSpaceCreateDeviceRGB failure");
        return nil;
    }
    
    void *baseAddress = CVPixelBufferGetBaseAddress(imageBuffer);
    
    size_t bufferSize = CVPixelBufferGetDataSize(imageBuffer);
    
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, baseAddress, bufferSize, NULL);
    
    CGImageRef cgImage = CGImageCreate(width, height, 8, 32, bytesPerRow, colorSpace, kCGImageAlphaNoneSkipFirst|kCGBitmapByteOrder32Little, provider, NULL, true, kCGRenderingIntentDefault);
    
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorSpace);
    
    // FIX: avfoundtion获取的视频流，默认就是旋转了90度的
//        UIImage *image = [UIImage imageWithCGImage:cgImage];
    UIImage *image = [UIImage imageWithCGImage:cgImage scale:1.0 orientation:(UIImageOrientationLeftMirrored)];
    
    UIImage *resultImage = [image sx_fixOrientation];
    CGImageRelease(cgImage);
    
    CVPixelBufferUnlockBaseAddress(imageBuffer, 0);
    
    return resultImage;
}

+ (unsigned char *)convertUIImageToBitmapRGBA8:(UIImage *)image {
    CGImageRef imageRef = image.CGImage;
    
    // Create a bitmap context to draw the UIImage into
    CGContextRef context = [self newBitmapRGBA8ContextFromImage:imageRef];
    
    if (!context) {
        return NULL;
    }
    
    size_t width = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    
    CGRect rect = CGRectMake(0, 0, width, height);
    
    // Draw image into the contxt to get the raw image data
    CGContextDrawImage(context, rect, imageRef); /// -----------> 内存会飙升
    
    // Get a pointer to the data
    unsigned char *bitmapData = (unsigned char *)CGBitmapContextGetData(context);
    
    // Copy the data and release the memory
    size_t bytesPerRow = CGBitmapContextGetBytesPerRow(context);
    size_t bufferLength = bytesPerRow * height;
    
    unsigned char *newBitmap = NULL;
    
    if (bitmapData) {
        newBitmap = (unsigned char *)malloc(sizeof(unsigned char) * bytesPerRow * height);
        
        if (newBitmap) {
            for (int i = 0; i < bufferLength; i++) {
                newBitmap[i] = bitmapData[i];
            }
        }
        free(bitmapData);
    } else {
        NSLog(@"error getting bitmap pixel data\n");
    }
    
    CGContextRelease(context);
    
    
    return newBitmap;
}

+ (CGContextRef)newBitmapRGBA8ContextFromImage:(CGImageRef)image {
    
    CGContextRef context = NULL;
    CGColorSpaceRef colorSpace;
    uint32_t *bitmapData;
    size_t bitsPerPixel = 32;
    size_t bitsPerComponent = 8;
    size_t bytesPerPixel = bitsPerPixel / bitsPerComponent;
    size_t width = CGImageGetWidth(image);
    size_t height = CGImageGetHeight(image);
    size_t bytesPerRow = width * bytesPerPixel;
    size_t bufferLength = bytesPerRow * height;
    colorSpace = CGColorSpaceCreateDeviceRGB();
    if (!colorSpace) {
        NSLog(@"Error allocating color space RGB\n");
        return NULL;
    }
    
    // Allocate memory for image data
    bitmapData = (uint32_t *)malloc(bufferLength);
    
    if (!bitmapData) {
        NSLog(@"Error allocating memory for bitmap\n");
        CGColorSpaceRelease(colorSpace);
        return NULL;
    }
    
    // Create bitmap context
    context = CGBitmapContextCreate(bitmapData,
                                    width,
                                    height,
                                    bitsPerComponent,
                                    bytesPerRow,
                                    colorSpace,
                                    kCGImageAlphaPremultipliedLast);
    
    if (!context) {
        free(bitmapData);
        NSLog(@"Bitmap context not created");
    }
    
    CGColorSpaceRelease(colorSpace);
    
    return context;
}

@end
