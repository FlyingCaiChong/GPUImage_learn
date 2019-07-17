//
//  GPUImageCustomAddPointsFilter.m
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/17.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import "GPUImageCustomAddPointsFilter.h"
#import "GPUImageCustomPointsGenerator.h"

@implementation GPUImageCustomAddPointsFilter

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    alphaBlendFilter = [[GPUImageAlphaBlendFilter alloc] init];
    [self addFilter:alphaBlendFilter];
    
    customPointsFilter = [[GPUImageCustomPointsGenerator alloc] init];
    customPointsFilter.pointWidth = 3;
    [customPointsFilter forceProcessingAtSize:CGSizeMake(720, 1280)];
    
    [self addFilter:customPointsFilter];
    
    // Texture location 0 needs to be the original image for the dissolve blend
    [customPointsFilter addTarget:alphaBlendFilter atTextureLocation:1];
    
    self.initialFilters = [NSArray arrayWithObjects:alphaBlendFilter, nil];
    self.terminalFilter = alphaBlendFilter;
    
    return self;
}

- (void)renderCrosshairsFromArray:(GLfloat *)crosshairCoordinates count:(NSUInteger)numberOfCrosshairs {
    
    CMTime frameTime = CMTimeMake(0, 1);
    [customPointsFilter renderCrosshairsFromArray:crosshairCoordinates count:numberOfCrosshairs frameTime:frameTime];
}

@end
