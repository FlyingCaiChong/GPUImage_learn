
//
//  GPUImageCustomLandmarkFilter.m
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/16.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import "GPUImageCustomLandmarkFilter.h"

@implementation GPUImageCustomLandmarkFilter

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    alphaBlendFilter = [[GPUImageAlphaBlendFilter alloc] init];
    [self addFilter:alphaBlendFilter];
    
    crosshairGenerator = [[GPUImageCrosshairGenerator alloc] init];
    crosshairGenerator.crosshairWidth = 10.0;
    [crosshairGenerator setCrosshairColorRed:1.0 green:0.0 blue:0.0];
    [crosshairGenerator forceProcessingAtSize:CGSizeMake(720, 1280)];
    [self addFilter:crosshairGenerator];
    
    // Texture location 0 needs to be the original image for the dissolve blend
    [crosshairGenerator addTarget:alphaBlendFilter atTextureLocation:1];
    
    self.initialFilters = [NSArray arrayWithObjects:alphaBlendFilter, nil];
    self.terminalFilter = alphaBlendFilter;
    
    return self;
}

- (void)renderCrosshairsFromArray:(GLfloat *)crosshairCoordinates count:(NSUInteger)numberOfCrosshairs {
    
    CMTime frameTime = CMTimeMake(0, 1);
    [crosshairGenerator renderCrosshairsFromArray:crosshairCoordinates count:numberOfCrosshairs frameTime:frameTime];
}

@end

