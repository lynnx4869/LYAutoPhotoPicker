//
//  LYAutoSwitchSheetView.m
//  LYAutoUtil
//
//  Created by xianing on 2017/4/21.
//  Copyright © 2017年 lyning. All rights reserved.
//

#import "LYAutoSwitchSheetView.h"

@implementation LYAutoSwitchSheetView

+ (LYAutoSwitchSheetView *)shareAutoSwitchSheetView{
    static LYAutoSwitchSheetView *view = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        view = [[LYAutoSwitchSheetView alloc] init];
    });
    return view;
}

- (void)showSheetView:(NSString *)title btns:(NSArray *)btns viewController:(UIViewController *)viewController btnClick:(BtnClickBlock)block {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:alertAction];
    
    for(NSDictionary *dic in btns){
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:dic[@"title"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            block(action.title);
        }];
        [alertController addAction:alertAction];
    }
    
    [viewController presentViewController:alertController animated:YES completion:nil];
}

@end
