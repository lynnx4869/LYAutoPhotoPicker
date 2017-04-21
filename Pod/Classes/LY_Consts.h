//
//  LY_Consts.h
//  LYAutoPhotoPicker
//
//  Created by xianing on 2017/4/21.
//  Copyright © 2017年 lyning. All rights reserved.
//

#ifndef LY_Consts_h
#define LY_Consts_h

#define ScreenWidth [[UIScreen mainScreen] bounds].size.width

#define ScreenHeight [[UIScreen mainScreen] bounds].size.height

//#e62f17
#define MainColor [UIColor colorWithRed:0.902 green:0.184 blue:0.09 alpha:1.0]

#define weakify(o) autoreleasepool{} __weak typeof(o) weak##o = o;

#define strongify(o) autoreleasepool{} __strong typeof(weak##o) o = weak##o;

#endif /* LY_Consts_h */
