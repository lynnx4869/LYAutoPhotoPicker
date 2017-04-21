//
//  LYAutoDatePickerController.h
//  LYAutoUtil
//
//  Created by xianing on 2017/4/21.
//  Copyright © 2017年 lyning. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SurePickBlock)(NSTimeInterval times);

@interface LYAutoDatePickerController : UIViewController

@property (nonatomic, copy) SurePickBlock block;

@property (nonatomic, assign) NSTimeInterval times;
@property (nonatomic, assign) NSTimeInterval maxTime;
@property (nonatomic, assign) NSTimeInterval minTime;

+ (instancetype)createPicker:(NSTimeInterval)time max:(NSTimeInterval)maxTime min:(NSTimeInterval)minTime sureBlock:(SurePickBlock)block;

@end
