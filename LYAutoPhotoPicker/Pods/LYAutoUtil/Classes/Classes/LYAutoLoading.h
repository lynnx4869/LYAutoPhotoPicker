//
//  LYAutoLoading.h
//  LYAutoUtil
//
//  Created by xianing on 2017/4/21.
//  Copyright © 2017年 lyning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYAutoLoadingView.h"

@interface LYAutoLoading : NSObject

+ (void)showLoading:(UIColor *)color animated:(BOOL)animated;
+ (void)hideLoading:(BOOL)animated;
+ (BOOL)isLoading;

@end
