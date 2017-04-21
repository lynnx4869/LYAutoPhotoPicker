//
//  LYAutoSwitchAlertView.m
//  LYAutoUtil
//
//  Created by xianing on 2017/4/21.
//  Copyright © 2017年 lyning. All rights reserved.
//

#import "LYAutoSwitchAlertView.h"

@interface LYAutoSwitchAlertView ()

@property (nonatomic, copy) SureClickBlock sureBlock;
@property (nonatomic, copy) CancelClickBlock cancelBlock;

@end

@implementation LYAutoSwitchAlertView

+ (LYAutoSwitchAlertView *)shareAutoSwitchAlertView{
    static LYAutoSwitchAlertView *view = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(view == nil){
            view = [[LYAutoSwitchAlertView alloc] init];
        }
    });
    return view;
}

- (void)showAlertView:(NSString *)title subText:(NSString *)subText isJudgment:(BOOL)isJudgment viewController:(UIViewController *)viewController sureClick:(SureClickBlock)sureBlock cancelBlock:(CancelClickBlock)cancelBlock {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:subText preferredStyle:UIAlertControllerStyleAlert];
    
    if (isJudgment) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            cancelBlock(@"取消");
        }];
        [alertController addAction:cancelAction];
        
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            sureBlock(@"确认");
        }];
        [alertController addAction:sureAction];
        
    } else {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            sureBlock(@"确认");
        }];
        [alertController addAction:cancelAction];
    }
    
    [viewController presentViewController:alertController animated:YES completion:nil];
}

@end
