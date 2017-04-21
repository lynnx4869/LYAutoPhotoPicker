//
//  LYAutoLoading.m
//  LYAutoUtil
//
//  Created by xianing on 2017/4/21.
//  Copyright © 2017年 lyning. All rights reserved.
//

#import "LYAutoLoading.h"

@interface LYAutoLoading ()

@property (nonatomic, strong) LYAutoLoadingView *autoLoadingView;

@property (nonatomic, assign) BOOL isShow;

@end

@implementation LYAutoLoading

+ (instancetype)shareAutoLoading {
    static LYAutoLoading *autoLoading = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(autoLoading == nil){
            autoLoading = [[LYAutoLoading alloc] init];
        }
    });
    return autoLoading;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isShow = NO;
    }
    return self;
}

+ (void)showLoading:(UIColor *)color animated:(BOOL)animated {
    LYAutoLoading *autoLoading = [LYAutoLoading shareAutoLoading];
    
    if (!autoLoading.isShow) {
        autoLoading.autoLoadingView = [[LYAutoLoadingView alloc] initWithColor:color];
        [[UIApplication sharedApplication].keyWindow addSubview:autoLoading.autoLoadingView];
        
        if(animated){
            POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
            anim.fromValue = @(0.0);
            anim.toValue = @(1.0);
            anim.duration = 1.0;
            
            [autoLoading.autoLoadingView pop_addAnimation:anim forKey:@"show"];
        }
        
        autoLoading.isShow = YES;
    }
}

+ (void)hideLoading:(BOOL)animated {
    LYAutoLoading *autoLoading = [LYAutoLoading shareAutoLoading];
    
    if(autoLoading.isShow){
        
        if(animated){
            POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
            anim.fromValue = @(1.0);
            anim.toValue = @(0.0);
            anim.duration = 1.0;
            
            [autoLoading.autoLoadingView pop_addAnimation:anim forKey:@"hide"];
            [autoLoading.autoLoadingView pop_removeAllAnimations];
        }
        
        [autoLoading.autoLoadingView.loadingBoard removeFromSuperview];
        autoLoading.autoLoadingView.loadingBoard = nil;
        
        [autoLoading.autoLoadingView removeFromSuperview];
        autoLoading.autoLoadingView = nil;
        
        autoLoading.isShow = NO;
    }
}

+ (BOOL)isLoading {
    LYAutoLoading *autoLoading = [LYAutoLoading shareAutoLoading];
    return autoLoading.isShow;
}

@end
