//
//  LYAutoPhotoAuthErrorViewController.h
//  LYAutoPhotoPicker
//
//  Created by xianing on 2017/4/21.
//  Copyright © 2017年 lyning. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LYAutoPhotoType) {
    LYAutoPhotoTypeCamera,
    LYAutoPhotoTypeAlbum,
};

@interface LYAutoPhotoAuthErrorViewController : UIViewController

@property (nonatomic, assign) LYAutoPhotoType type;

@end
