//
//  GPUImageCustomLipstickFilter.m
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/19.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import "GPUImageCustomLipstickFilter.h"
#import "GPUImageCustomLipstickGenerator.h"

@implementation GPUImageCustomLipstickFilter

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    alphaBlendFilter = [[GPUImageAlphaBlendFilter alloc] init];
    [self addFilter:alphaBlendFilter];
    
    lipstickGenerator = [[GPUImageCustomLipstickGenerator alloc] init];
    
    [lipstickGenerator forceProcessingAtSize:CGSizeMake(720, 1280)];
    
    [self addFilter:lipstickGenerator];
    
    // Texture location 0 needs to be the original image for the dissolve blend
    [lipstickGenerator addTarget:alphaBlendFilter atTextureLocation:1];
    
    self.initialFilters = [NSArray arrayWithObjects:alphaBlendFilter, nil];
    self.terminalFilter = alphaBlendFilter;
    
    return self;
}

- (void)setTexelWidthOffset:(CGFloat)texelWidthOffset {
    lipstickGenerator.texelWidthOffset = texelWidthOffset;
}

- (void)setTexelHeightOffset:(CGFloat)texelHeightOffset {
    lipstickGenerator.texelHeightOffset = texelHeightOffset;
}

- (void)setColorRed:(GLfloat)redComponent green:(GLfloat)greenComponent blue:(GLfloat)blueComponent {
    [lipstickGenerator setColorRed:redComponent green:greenComponent blue:blueComponent];
}

- (void)renderPointsFromArray:(GLfloat *)points count:(NSUInteger)numberOfPoints {
    // iOS默认输出的视频帧率为30帧/秒
    CMTime frameTime = CMTimeMake(1, 30);
    [lipstickGenerator renderLipstickFromArray:points count:numberOfPoints frameTime:frameTime];
}

@end
