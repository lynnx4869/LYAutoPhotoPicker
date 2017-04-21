//
//  LYImageToBase64.h
//  LYAutoUtil
//
//  Created by xianing on 2017/4/21.
//  Copyright © 2017年 lyning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYImageToBase64 : NSObject

/**
 将图片转成Base64码
 
 @param url 图片相对路径
 @return Base64字符串
 */
+ (NSString *)imageToBase64:(NSString *)url;


/**
 压缩图片
 
 @param image 传入图片
 @return 输出图片
 */
+ (UIImage *)compressImage:(UIImage *)image;

@end
