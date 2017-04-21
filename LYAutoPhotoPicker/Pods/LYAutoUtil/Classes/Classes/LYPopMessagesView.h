//
//  LYPopMessagesView.h
//  LYAutoUtil
//
//  Created by xianing on 2017/4/21.
//  Copyright © 2017年 lyning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYPopMessages.h"

@interface LYPopMessagesView : UIView

@property (nonatomic, strong) NSString *message;
@property (nonatomic, assign) LYPopMessagesNotificationType type;

@end
