//
//  WKWebView+LYClean.h
//  LYAutoUtil
//
//  Created by xianing on 2017/4/21.
//  Copyright © 2017年 lyning. All rights reserved.
//

#import <WebKit/WebKit.h>

@interface WKWebView (LYClean)

/**
 清空WebView
 */
- (void) cleanForDealloc;

@end
