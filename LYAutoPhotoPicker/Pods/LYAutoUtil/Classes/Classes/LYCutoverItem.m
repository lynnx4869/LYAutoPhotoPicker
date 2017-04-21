//
//  LYCutoverItem.m
//  LYAutoUtil
//
//  Created by xianing on 2017/4/21.
//  Copyright © 2017年 lyning. All rights reserved.
//

#import "LYCutoverItem.h"

@interface LYCutoverItem()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation LYCutoverItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:14.0];
        self.titleLabel.textColor = [UIColor blackColor];
        [self addSubview:self.titleLabel];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickToSelect:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    self.titleLabel.text = title;
}

- (void)setIsSelect:(BOOL)isSelect {
    _isSelect = isSelect;
    
    if(isSelect){
        self.titleLabel.textColor = _mainColor;
    }else{
        self.titleLabel.textColor = [UIColor blackColor];
    }
}

- (void)clickToSelect:(UITapGestureRecognizer *)tap {
    [_delegate cutoverItemCallback:_index];
}

@end
