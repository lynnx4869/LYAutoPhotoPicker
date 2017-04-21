//
//  PhotosViewController.h
//  tpsc
//
//  Created by xianing on 2017/3/8.
//  Copyright © 2017年 czcg. All rights reserved.
//

#import "PhotoBasicViewController.h"
#import <Masonry.h>
#import <Photos/Photos.h>

typedef void(^CompleteBlock)(BOOL result, NSArray<UIImage *> *images);

@interface PhotosViewController : PhotoBasicViewController

@property (nonatomic, strong) PHAssetCollection *assetCollection;

@property (nonatomic, assign) NSInteger maxSelects;

@end
