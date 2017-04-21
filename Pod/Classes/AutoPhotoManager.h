//
//  AutoPhotoManager.h
//  tpsc
//
//  Created by xianing on 2017/3/12.
//  Copyright © 2017年 czcg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CameraUtilViewController.h"
#import "AlbumsViewController.h"
#import "AutoPhotoAuthErrorViewController.h"

typedef void(^CheckAuthBlock)(UIViewController *vc);

@interface AutoPhotoManager : NSObject

@property (nonatomic, assign) AutoPhotoType type;

@property (nonatomic, assign) BOOL isRateTailor;
@property (nonatomic, assign) double tailoringRate;

@property (nonatomic, assign) NSInteger maxSelects;
@property (nonatomic, copy) CompleteBlock block;

- (void)checkPhotoAuth:(CheckAuthBlock)block;

@end
