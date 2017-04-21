//
//  UIColor+LYUtil.h
//  LYAutoUtil
//
//  Created by xianing on 2017/4/21.
//  Copyright © 2017年 lyning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (LYUtil)

/**
 *  从16进制获取UIColor
 *
 *  @param hexValue 16进制颜色值 ： 如 :#007ac0 即为 0x15A230
 *  @param alpha    透明度 0 ~ 1
 *
 *  @return UIColor
 */
+ (UIColor *)colorWithHex:(int)hexValue alpha:(CGFloat)alpha;

/**
 *  从16进制获取UIColor alpha 默认为1
 *  采用16进制便于 Android 开发统一
 *
 *  @param hexValue 16进制颜色值 ： 如 :#007ac0 即为 0x15A230
 *
 *  @return UIColor
 */
+ (UIColor *)colorWithHex:(int)hexValue;

@end
