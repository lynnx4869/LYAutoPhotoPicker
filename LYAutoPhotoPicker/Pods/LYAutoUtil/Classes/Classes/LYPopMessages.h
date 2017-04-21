//
//  LYPopMessages.h
//  LYAutoUtil
//
//  Created by xianing on 2017/4/21.
//  Copyright © 2017年 lyning. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LYPopMessagesNotificationType) {
    LYPopMessagesNotificationTypeSuccess = 0,
    LYPopMessagesNotificationTypeWarming,
    LYPopMessagesNotificationTypeError
};

@interface LYPopMessages : NSObject

+ (void)showNotificationInViewController:(NSString *)message
                                    type:(LYPopMessagesNotificationType)type
                                duration:(NSTimeInterval)duration;

@end
