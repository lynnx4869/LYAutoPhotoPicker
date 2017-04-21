//
//  LYAutoSwitchAlertView.h
//  LYAutoUtil
//
//  Created by xianing on 2017/4/21.
//  Copyright © 2017年 lyning. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SureClickBlock)(NSString *title);
typedef void(^CancelClickBlock)(NSString *title);

@interface LYAutoSwitchAlertView : NSObject

+ (LYAutoSwitchAlertView *)shareAutoSwitchAlertView;

- (void)showAlertView:(NSString *)title subText:(NSString *)subText isJudgment:(BOOL)isJudgment viewController:(UIViewController *)viewController sureClick:(SureClickBlock)sureBlock cancelBlock:(CancelClickBlock)cancelBlock;

@end
