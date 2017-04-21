//
//  LYPopMessages.m
//  LYAutoUtil
//
//  Created by xianing on 2017/4/21.
//  Copyright © 2017年 lyning. All rights reserved.
//

#import "LYPopMessages.h"
#import "LYPopMessagesView.h"
#import <pop/POP.h>
#import "LYAutoUtil_Consts.h"

@implementation LYPopMessages

+ (void)showNotificationInViewController:(NSString *)message type:(LYPopMessagesNotificationType)type duration:(NSTimeInterval)duration {
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    LYPopMessagesView *popMessagesView = [[LYPopMessagesView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, 30)];
    popMessagesView.message = message;
    popMessagesView.type = type;
    [window addSubview:popMessagesView];
    
    POPBasicAnimation *addAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    addAnim.fromValue = @(0.0);
    addAnim.toValue = @(1.0);
    addAnim.duration = 1.0;
    [popMessagesView pop_addAnimation:addAnim forKey:@"fade"];
    
    __weak LYPopMessagesView *weakPop = popMessagesView;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakPop pop_removeAnimationForKey:@"fade"];
        
        [weakPop removeFromSuperview];
    });
    
}

@end
