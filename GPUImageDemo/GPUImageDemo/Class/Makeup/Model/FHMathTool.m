//
//  FHMathTool.m
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/17.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import "FHMathTool.h"
#import <GLKit/GLKit.h>

@implementation FHMathTool

+ (NSArray *)getRectByPoints:(NSArray *)points {
    
    NSMutableArray *rect = [NSMutableArray arrayWithCapacity:4];
    
    NSInteger minx = [points[0] integerValue];
    NSInteger miny = [points[1] integerValue];
    NSInteger maxx = [points[0] integerValue];
    NSInteger maxy = [points[1] integerValue];
    
    for (NSInteger i = 0; i < points.count/2; i++) {
        NSInteger x = [points[2 * i] integerValue];
        NSInteger y = [points[2 * i + 1] integerValue];
        minx = MIN(minx, x);
        maxx = MAX(maxx, x);
        miny = MIN(miny, y);
        maxy = MAX(maxy, y);
    }
    
    NSInteger rect0 = minx - 5;
    NSInteger rect1 = miny - 5;
    NSInteger rect2 = maxx + 5;
    NSInteger rect3 = maxy + 5;
    
    [rect addObject:@(rect0)];
    [rect addObject:@(rect1)];
    [rect addObject:@(rect2)];
    [rect addObject:@(rect3)];
    
    return [rect copy];
}

+ (void)addPointY1:(CGFloat)y1
                y2:(CGFloat)y2
                 x:(NSInteger)x
             xList:(NSMutableArray *)xList
             yList:(NSMutableArray *)yList {
    
    NSInteger a = y1 + 0.5;
    NSInteger b = y2 + 0.5;
    for (NSInteger i = a; i < b; i++) {
        [xList addObject:@(i)];
        [yList addObject:@(x)];
    }
}

+ (CGFloat)getPointYByABCWithX:(CGFloat)x
                           abc:(NSArray *)abc {
    CGFloat y = 0;
    y = [abc[0] floatValue] * x * x + [abc[1] floatValue] * x + [abc[2] floatValue];
    return y;
}

+ (NSArray *)getABCWithPoints:(NSArray *)points {
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:3];
    
    float Dm00 = [points[0] integerValue] * [points[0] integerValue];
    float Dm01 = [points[0] integerValue];
    float Dm02 = 1;
    float Dm10 = [points[2] integerValue] * [points[2] integerValue];
    float Dm11 = [points[2] integerValue];
    float Dm12 = 1;
    float Dm20 = [points[4] integerValue] * [points[4] integerValue];
    float Dm21 = [points[4] integerValue];
    float Dm22 = 1;
    GLKMatrix3 D = GLKMatrix3Make(Dm00, Dm01, Dm02, Dm10, Dm11, Dm12, Dm20, Dm21, Dm22);
    
    float D1m00 = [points[1] integerValue];
    float D1m01 = [points[0] integerValue];
    float D1m02 = 1;
    float D1m10 = [points[3] integerValue];
    float D1m11 = [points[2] integerValue];
    float D1m12 = 1;
    float D1m20 = [points[5] integerValue];
    float D1m21 = [points[4] integerValue];
    float D1m22 = 1;
    GLKMatrix3 D1 = GLKMatrix3Make(D1m00, D1m01, D1m02, D1m10, D1m11, D1m12, D1m20, D1m21, D1m22);
    
    float D2m00 = [points[0] integerValue] * [points[0] integerValue];
    float D2m01 = [points[1] integerValue];
    float D2m02 = 1;
    float D2m10 = [points[2] integerValue] * [points[2] integerValue];
    float D2m11 = [points[3] integerValue];
    float D2m12 = 1;
    float D2m20 = [points[4] integerValue] * [points[4] integerValue];
    float D2m21 = [points[5] integerValue];
    float D2m22 = 1;
    GLKMatrix3 D2 = GLKMatrix3Make(D2m00, D2m01, D2m02, D2m10, D2m11, D2m12, D2m20, D2m21, D2m22);
    
    float D3m00 = [points[0] integerValue] * [points[0] integerValue];
    float D3m01 = [points[0] integerValue];
    float D3m02 = [points[1] integerValue];
    float D3m10 = [points[2] integerValue] * [points[2] integerValue];
    float D3m11 = [points[2] integerValue];
    float D3m12 = [points[3] integerValue];
    float D3m20 = [points[4] integerValue] * [points[4] integerValue];
    float D3m21 = [points[4] integerValue];
    float D3m22 = [points[5] integerValue];
    GLKMatrix3 D3 = GLKMatrix3Make(D3m00, D3m01, D3m02, D3m10, D3m11, D3m12, D3m20, D3m21, D3m22);
    
    CGFloat result0 = [self detForMatrix3:D1]/[self detForMatrix3:D];
    CGFloat result1 = [self detForMatrix3:D2]/[self detForMatrix3:D];
    CGFloat result2 = [self detForMatrix3:D3]/[self detForMatrix3:D];
    
    [result addObject:@(result0)];
    [result addObject:@(result1)];
    [result addObject:@(result2)];
    
    return [result copy];
}



+ (CGFloat)getPointYByABCDWithX:(CGFloat)x abcd:(NSArray *)abcd {
    CGFloat y = 0;
    y = [abcd[0] floatValue] * x * x * x + [abcd[1] floatValue] * x * x + [abcd[2] floatValue] * x + [abcd[3] floatValue];
    return y;
}

+ (NSArray *)getABCDWithPoints:(NSArray *)points {
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:4];
    
    float Dm00 = pow([points[0] integerValue], 3);
    float Dm01 = pow([points[0] integerValue], 2);
    float Dm02 = [points[0] integerValue];
    float Dm03 = 1;
    float Dm10 = pow([points[2] integerValue], 3);
    float Dm11 = pow([points[2] integerValue], 2);
    float Dm12 = [points[2] integerValue];
    float Dm13 = 1;
    float Dm20 = pow([points[4] integerValue], 3);
    float Dm21 = pow([points[4] integerValue], 2);
    float Dm22 = [points[4] integerValue];
    float Dm23 = 1;
    float Dm30 = pow([points[6] integerValue], 3);
    float Dm31 = pow([points[6] integerValue], 2);
    float Dm32 = [points[6] integerValue];
    float Dm33 = 1;
    GLKMatrix4 D = GLKMatrix4Make(Dm00, Dm01, Dm02, Dm03,
                                  Dm10, Dm11, Dm12, Dm13,
                                  Dm20, Dm21, Dm22, Dm23,
                                  Dm30, Dm31, Dm32, Dm33);
    
    float D1m00 = [points[1] integerValue];
    float D1m01 = pow([points[0] integerValue], 2);
    float D1m02 = [points[0] integerValue];
    float D1m03 = 1;
    float D1m10 = [points[3] integerValue];
    float D1m11 = pow([points[2] integerValue], 2);
    float D1m12 = [points[2] integerValue];
    float D1m13 = 1;
    float D1m20 = [points[5] integerValue];
    float D1m21 = pow([points[4] integerValue], 2);
    float D1m22 = [points[4] integerValue];
    float D1m23 = 1;
    float D1m30 = [points[7] integerValue];
    float D1m31 = pow([points[6] integerValue], 2);
    float D1m32 = [points[6] integerValue];
    float D1m33 = 1;
    GLKMatrix4 D1 = GLKMatrix4Make(D1m00, D1m01, D1m02, D1m03,
                                  D1m10, D1m11, D1m12, D1m13,
                                  D1m20, D1m21, D1m22, D1m23,
                                  D1m30, D1m31, D1m32, D1m33);
    
    float D2m00 = pow([points[0] integerValue], 3);
    float D2m01 = [points[1] integerValue];
    float D2m02 = [points[0] integerValue];
    float D2m03 = 1;
    float D2m10 = pow([points[2] integerValue], 3);
    float D2m11 = [points[3] integerValue];
    float D2m12 = [points[2] integerValue];
    float D2m13 = 1;
    float D2m20 = pow([points[4] integerValue], 3);
    float D2m21 = [points[5] integerValue];
    float D2m22 = [points[4] integerValue];
    float D2m23 = 1;
    float D2m30 = pow([points[6] integerValue], 3);
    float D2m31 = [points[7] integerValue];
    float D2m32 = [points[6] integerValue];
    float D2m33 = 1;
    GLKMatrix4 D2 = GLKMatrix4Make(D2m00, D2m01, D2m02, D2m03,
                                   D2m10, D2m11, D2m12, D2m13,
                                   D2m20, D2m21, D2m22, D2m23,
                                   D2m30, D2m31, D2m32, D2m33);
    
    
    float D3m00 = pow([points[0] integerValue], 3);
    float D3m01 = pow([points[0] integerValue], 2);
    float D3m02 = [points[1] integerValue];
    float D3m03 = 1;
    float D3m10 = pow([points[2] integerValue], 3);
    float D3m11 = pow([points[2] integerValue], 2);
    float D3m12 = [points[3] integerValue];
    float D3m13 = 1;
    float D3m20 = pow([points[4] integerValue], 3);
    float D3m21 = pow([points[4] integerValue], 2);
    float D3m22 = [points[5] integerValue];
    float D3m23 = 1;
    float D3m30 = pow([points[6] integerValue], 3);
    float D3m31 = pow([points[6] integerValue], 2);
    float D3m32 = [points[7] integerValue];
    float D3m33 = 1;
    GLKMatrix4 D3 = GLKMatrix4Make(D3m00, D3m01, D3m02, D3m03,
                                   D3m10, D3m11, D3m12, D3m13,
                                   D3m20, D3m21, D3m22, D3m23,
                                   D3m30, D3m31, D3m32, D3m33);
    
    float D4m00 = pow([points[0] integerValue], 3);
    float D4m01 = pow([points[0] integerValue], 2);
    float D4m02 = [points[0] integerValue];
    float D4m03 = [points[1] integerValue];
    float D4m10 = pow([points[2] integerValue], 3);
    float D4m11 = pow([points[2] integerValue], 2);
    float D4m12 = [points[2] integerValue];
    float D4m13 = [points[3] integerValue];
    float D4m20 = pow([points[4] integerValue], 3);
    float D4m21 = pow([points[4] integerValue], 2);
    float D4m22 = [points[4] integerValue];
    float D4m23 = [points[5] integerValue];
    float D4m30 = pow([points[6] integerValue], 3);
    float D4m31 = pow([points[6] integerValue], 2);
    float D4m32 = [points[6] integerValue];
    float D4m33 = [points[7] integerValue];
    GLKMatrix4 D4 = GLKMatrix4Make(D4m00, D4m01, D4m02, D4m03,
                                   D4m10, D4m11, D4m12, D4m13,
                                   D4m20, D4m21, D4m22, D4m23,
                                   D4m30, D4m31, D4m32, D4m33);
    
    CGFloat result0 = [self detForMatrix4:D1]/[self detForMatrix4:D];
    CGFloat result1 = [self detForMatrix4:D2]/[self detForMatrix4:D];
    CGFloat result2 = [self detForMatrix4:D3]/[self detForMatrix4:D];
    CGFloat result3 = [self detForMatrix4:D4]/[self detForMatrix4:D];
    
    [result addObject:@(result0)];
    [result addObject:@(result1)];
    [result addObject:@(result2)];
    [result addObject:@(result3)];
    
    return [result copy];
}

+ (CGFloat)detForMatrix3:(GLKMatrix3)matrix {
    /**
     m00 m01 m02
     m10 m11 m12
     m20 m21 m22
     D = m00 * (m11 * m22 - m21 * m12) - m10 * (m01 * m22 - m21 * m02) + m20 * (m01 * m12 - m11 * m02)
     D = m00 * m11 * m22 +
         m10 * m21 * m02 +
         m20 * m01 * m12 -
         m20 * m11 * m02 -
         m10 * m01 * m22 -
         m00 * m21 * m12
    */
    CGFloat D = 0;
    D = matrix.m00 * matrix.m11 * matrix.m22 +
        matrix.m10 * matrix.m21 * matrix.m02 +
        matrix.m20 * matrix.m01 * matrix.m12 -
        matrix.m20 * matrix.m11 * matrix.m02 -
        matrix.m10 * matrix.m01 * matrix.m22 -
        matrix.m00 * matrix.m21 * matrix.m12;
    
    return D;
}

+ (CGFloat)detForMatrix4:(GLKMatrix4)matrix {
    
    /**
     m00 m01 m02 m03
     m10 m11 m12 m13
     m20 m21 m22 m23
     m30 m31 m32 m33
     D = m00 * m11 * m22 * m33 +
         m10 * m21 * m32 * m03 +
         m20 * m31 * m02 * m13 +
         m30 * m01 * m12 * m23 -
         m30 * m21 * m12 * m03 -
         m20 * m11 * m02 * m33 -
         m10 * m01 * m32 * m23 -
         m00 * m31 * m22 * m13
     */
    CGFloat D = 0;
    D = matrix.m00 * matrix.m11 * matrix.m22 * matrix.m33 +
        matrix.m10 * matrix.m21 * matrix.m32 * matrix.m03 +
        matrix.m20 * matrix.m31 * matrix.m02 * matrix.m13 +
        matrix.m30 * matrix.m01 * matrix.m12 * matrix.m23 -
        matrix.m30 * matrix.m21 * matrix.m12 * matrix.m03 -
        matrix.m20 * matrix.m11 * matrix.m02 * matrix.m33 -
        matrix.m10 * matrix.m01 * matrix.m32 * matrix.m23 -
        matrix.m00 * matrix.m31 * matrix.m22 * matrix.m13;
    return D;
}

@end
