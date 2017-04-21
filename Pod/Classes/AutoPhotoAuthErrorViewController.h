//
//  AutoPhotoAuthErrorViewController.h
//  tpsc
//
//  Created by xianing on 2017/3/12.
//  Copyright © 2017年 czcg. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AutoPhotoType) {
    AutoPhotoTypeCamera,
    AutoPhotoTypeAlbum,
};

@interface AutoPhotoAuthErrorViewController : UIViewController

@property (nonatomic, assign) AutoPhotoType type;

@end
