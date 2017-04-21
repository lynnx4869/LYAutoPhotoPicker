//
//  WKWebView+LYClean.m
//  LYAutoUtil
//
//  Created by xianing on 2017/4/21.
//  Copyright © 2017年 lyning. All rights reserved.
//

#import "WKWebView+LYClean.h"

@implementation WKWebView (LYClean)

- (void) cleanForDealloc
{
    /*
     
     There are several theories and rumors about UIWebView memory leaks, and how
     to properly handle cleaning a UIWebView instance up before deallocation. This
     method implements several of those recommendations.
     
     #1: Various developers believe UIWebView may not properly throw away child
     objects & views without forcing the UIWebView to load empty content before
     dealloc.
     
     Source: http://stackoverflow.com/questions/648396/does-uiwebview-leak-memory
     
     */
    [self loadHTMLString:@"" baseURL:nil];
    
    /*
     
     #2: Others claim that UIWebView's will leak if they are loading content
     during dealloc.
     
     Source: http://stackoverflow.com/questions/6124020/uiwebview-leaking
     
     */
    [self stopLoading];
    
    /*
     
     #3: Apple recommends setting the delegate to nil before deallocation:
     "Important: Before releasing an instance of UIWebView for which you have set
     a delegate, you must first set the UIWebView delegate property to nil before
     disposing of the UIWebView instance. This can be done, for example, in the
     dealloc method where you dispose of the UIWebView."
     
     Source: UIWebViewDelegate class reference
     
     */
    self.navigationDelegate = nil;
    
    
    /*
     
     #4: If you're creating multiple child views for any given view, and you're
     trying to deallocate an old child, that child is pointed to by the parent
     view, and won't actually deallocate until that parent view dissapears. This
     call below ensures that you are not creating many child views that will hang
     around until the parent view is deallocated.
     */
    
    [self removeFromSuperview];
}

@end
