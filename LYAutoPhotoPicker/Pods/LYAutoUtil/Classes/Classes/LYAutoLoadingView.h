//
//  LYAutoLoadingView.h
//  LYAutoUtil
//
//  Created by xianing on 2017/4/21.
//  Copyright © 2017年 lyning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <pop/POP.h>

@interface LYAutoLoadingView : UIView

@property (nonatomic, strong) UIView *loadingBoard;

- (instancetype)initWithColor:(UIColor *)color;

@end
