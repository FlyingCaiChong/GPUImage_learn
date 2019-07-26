//
//  GPUImageCustomFaceChangeGroup.m
//  GPUImageDemo
//
//  Created by iOS_Developer on 2019/7/25.
//  Copyright © 2019年 iOS_Developer. All rights reserved.
//

#import "GPUImageCustomFaceChangeGroup.h"

@implementation GPUImageCustomFaceChangeGroup

- (instancetype)init
{
    self = [super init];
    if (self) {
        faceChangeFilter = [[GPUImageCustomFaceChangeFilter alloc] init];
        [self addFilter:faceChangeFilter];
        
        addPointsFilter = [[GPUImageCustomFaceDetectPointFilter alloc] init];
        addPointsFilter.isShowFaceDetectPointBool = YES;
        [self addFilter:addPointsFilter];
        
        blendFilter = [[GPUImageScreenBlendFilter alloc] init];
        [self addFilter:blendFilter];
        
        [faceChangeFilter addTarget:blendFilter atTextureLocation:0];
        [addPointsFilter addTarget:blendFilter atTextureLocation:1];
        
        self.initialFilters = [NSArray arrayWithObjects:faceChangeFilter, addPointsFilter, blendFilter, nil];
        self.terminalFilter = blendFilter;
    }
    return self;
}

- (void)setFacePointArray:(NSArray *)pointArray width:(CGFloat)width height:(CGFloat)height {
    [faceChangeFilter setFacePointArray:pointArray width:width height:height];
    [addPointsFilter setFacePointsArray:pointArray];
}

- (void)setIsHaveFace:(BOOL)isHaveFace {
    faceChangeFilter.isHaveFace = isHaveFace;
}

- (void)setThinFaceParam:(CGFloat)thinFaceParam {
    faceChangeFilter.thinFaceParam = thinFaceParam;
}

- (void)setEyeParam:(CGFloat)eyeParam {
    faceChangeFilter.eyeParam = eyeParam;
}

- (void)setNoseParam:(CGFloat)noseParam {
    faceChangeFilter.noseParam = noseParam;
}

@end
