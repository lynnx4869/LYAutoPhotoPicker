//
//  PhotoBasicViewController.h
//  tpsc
//
//  Created by xianing on 2017/3/12.
//  Copyright © 2017年 czcg. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CompleteBlock)(BOOL result, NSArray<UIImage *> *images);

@interface PhotoBasicViewController : UIViewController

@property (nonatomic, assign) BOOL isRateTailor;
@property (nonatomic, assign) double tailoringRate;

@property (nonatomic, copy) CompleteBlock block;

@end
