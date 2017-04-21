//
//  LYAutoUtil_Consts.h
//  LYAutoUtil
//
//  Created by xianing on 2017/4/21.
//  Copyright © 2017年 lyning. All rights reserved.
//

#ifndef LYAutoUtil_Consts_h
#define LYAutoUtil_Consts_h

#define ScreenWidth [[UIScreen mainScreen] bounds].size.width

#define ScreenHeight [[UIScreen mainScreen] bounds].size.height

#define weakify(o) autoreleasepool{} __weak typeof(o) weak##o = o;

#define strongify(o) autoreleasepool{} __strong typeof(weak##o) o = weak##o;


#endif /* LYAutoUtil_Consts_h */
