//
//  LYImageToBase64.m
//  LYAutoUtil
//
//  Created by xianing on 2017/4/21.
//  Copyright © 2017年 lyning. All rights reserved.
//

#import "LYImageToBase64.h"
#import <math.h>

@implementation LYImageToBase64

+ (NSString *)imageToBase64:(NSString *)url {
    UIImage *image = [UIImage imageWithContentsOfFile:url];
    
    UIImage *scaledImage = [LYImageToBase64 compressImage:image];
    
    NSData *data = UIImageJPEGRepresentation(scaledImage, 1.0);
    return [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
}

+ (UIImage *)compressImage:(UIImage *)image {
    CGSize size = CGSizeMake(400, 400*image.size.height/image.size.width);
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

@end
