//
//  LYPopMessagesView.m
//  LYAutoUtil
//
//  Created by xianing on 2017/4/21.
//  Copyright © 2017年 lyning. All rights reserved.
//

#import "LYPopMessagesView.h"
#import "LYAutoUtil_Consts.h"

@interface LYPopMessagesView ()

@property (nonatomic, strong) UIImageView *leftIcon;
@property (nonatomic, strong) UILabel *messageLabel;

@end

@implementation LYPopMessagesView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _leftIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 14, 14)];
        [self addSubview:_leftIcon];
        
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(34, 0, ScreenWidth-44, 30)];
        _messageLabel.font = [UIFont systemFontOfSize:12];
        _messageLabel.textColor = [UIColor whiteColor];
        [self addSubview:_messageLabel];
    }
    return self;
}

- (void)setType:(LYPopMessagesNotificationType)type {
    _type = type;
    
    _messageLabel.text = _message;
    
    if (type == LYPopMessagesNotificationTypeSuccess) {
        self.backgroundColor = [UIColor colorWithRed:0.086 green:0.627 blue:0.522 alpha:1.0];
        _leftIcon.image = [UIImage imageNamed:@"ly_message_ok"];
    } else {
        self.backgroundColor = [UIColor colorWithRed:0.851 green:0.329 blue:0.31 alpha:1.0];
        _leftIcon.image = [UIImage imageNamed:@"ly_message_warning"];
    }
}

@end
