//
//  LYPhotoBasicViewController.h
//  LYAutoPhotoPicker
//
//  Created by xianing on 2017/4/21.
//  Copyright © 2017年 lyning. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CompleteBlock)(BOOL result, NSArray<UIImage *> *images);

@interface LYPhotoBasicViewController : UIViewController

@property (nonatomic, assign) BOOL isRateTailor;
@property (nonatomic, assign) double tailoringRate;

@property (nonatomic, copy) CompleteBlock block;

@end
