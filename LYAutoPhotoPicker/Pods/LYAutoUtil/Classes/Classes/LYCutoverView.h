//
//  LYCutoverView.h
//  LYAutoUtil
//
//  Created by xianing on 2017/4/21.
//  Copyright © 2017年 lyning. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickBlock)(NSInteger index);

@interface LYCutoverView : UIView

@property (nonatomic, strong) UIColor *mainColor;

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, copy) ClickBlock clickBlock;

@end
