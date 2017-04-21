//
//  UIImage+LYPureImage.h
//  LYAutoUtil
//
//  Created by xianing on 2017/4/21.
//  Copyright © 2017年 lyning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LYPureImage)

/**
 获取纯色图片
 
 @param color 图片颜色
 @return 纯色图片
 */
+ (UIImage *)pureImageWithColor:(int)color;


/**
 绘制图片颜色

 @param color color
 @return new image
 */
- (UIImage *)imageContentWithColor:(UIColor *)color;

@end
