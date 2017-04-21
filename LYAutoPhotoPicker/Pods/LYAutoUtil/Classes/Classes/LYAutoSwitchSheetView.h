//
//  LYAutoSwitchSheetView.h
//  LYAutoUtil
//
//  Created by xianing on 2017/4/21.
//  Copyright © 2017年 lyning. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BtnClickBlock)(NSString *title);

@interface LYAutoSwitchSheetView : NSObject

+ (LYAutoSwitchSheetView *)shareAutoSwitchSheetView;

- (void)showSheetView:(NSString *)title btns:(NSArray *)btns viewController:(UIViewController *)viewController btnClick:(BtnClickBlock)block;

@end
