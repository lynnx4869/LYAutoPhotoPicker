//
//  UIImage+LYPureImage.m
//  LYAutoUtil
//
//  Created by xianing on 2017/4/21.
//  Copyright © 2017年 lyning. All rights reserved.
//

#import "UIImage+LYPureImage.h"
#import "UIColor+LYUtil.h"

@implementation UIImage (LYPureImage)

+ (UIImage *)pureImageWithColor:(int)color {
    
    CGSize imageSize = CGSizeMake(10,10);
    
    UIGraphicsBeginImageContextWithOptions(imageSize,0, 0);
    [[UIColor colorWithHex:color] set];
    
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    
    UIImage *pureImage =UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return pureImage;
}

- (UIImage *)imageContentWithColor:(UIColor *)color {
    UIImage *newImage = nil;
    
    CGRect imageRect = (CGRect){CGPointZero,self.size};
    UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, self.scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextTranslateCTM(context, 0.0, -(imageRect.size.height));
    
    CGContextClipToMask(context, imageRect, self.CGImage);//选中选区 获取不透明区域路径
    CGContextSetFillColorWithColor(context, color.CGColor);//设置颜色
    CGContextFillRect(context, imageRect);//绘制
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();//提取图片
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
