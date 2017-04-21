//
//  LYAutoPhotoManager.h
//  LYAutoPhotoPicker
//
//  Created by xianing on 2017/4/21.
//  Copyright © 2017年 lyning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYCameraUtilViewController.h"
#import "LYAlbumsViewController.h"
#import "LYAutoPhotoAuthErrorViewController.h"

typedef void(^CheckAuthBlock)(UIViewController *vc);

@interface LYAutoPhotoManager : NSObject

@property (nonatomic, assign) LYAutoPhotoType type;

@property (nonatomic, assign) BOOL isRateTailor;
@property (nonatomic, assign) double tailoringRate;

@property (nonatomic, assign) NSInteger maxSelects;
@property (nonatomic, copy) CompleteBlock block;

- (void)checkPhotoAuth:(CheckAuthBlock)block;

@end
