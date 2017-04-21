//
//  LYPhotosViewController.h
//  LYAutoPhotoPicker
//
//  Created by xianing on 2017/4/21.
//  Copyright © 2017年 lyning. All rights reserved.
//

#import "LYPhotoBasicViewController.h"
#import <Masonry/Masonry.h>
#import <Photos/Photos.h>

typedef void(^CompleteBlock)(BOOL result, NSArray<UIImage *> *images);

@interface LYPhotosViewController : LYPhotoBasicViewController

@property (nonatomic, strong) PHAssetCollection *assetCollection;

@property (nonatomic, assign) NSInteger maxSelects;

@end
