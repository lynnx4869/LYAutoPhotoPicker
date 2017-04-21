//
//  LYAutoLoadingView.m
//  LYAutoUtil
//
//  Created by xianing on 2017/4/21.
//  Copyright © 2017年 lyning. All rights reserved.
//

#import "LYAutoLoadingView.h"
#import "LYAutoUtil_Consts.h"
#import "UIImage+LYPureImage.h"

@implementation LYAutoLoadingView

- (instancetype)initWithColor:(UIColor *)color
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        bgView.backgroundColor = [UIColor clearColor];
        bgView.alpha = 0.5;
        [self addSubview:bgView];
        
        [self createLogoViews:color];
    }
    return self;
}

- (void)createLogoViews:(UIColor *)color {
    _loadingBoard = [[UIView alloc] init];
    _loadingBoard.frame = CGRectMake(0, 0, 140, 100);
    _loadingBoard.center = self.center;
    _loadingBoard.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
    _loadingBoard.layer.masksToBounds = YES;
    _loadingBoard.layer.cornerRadius = 14.0;
    _loadingBoard.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _loadingBoard.layer.borderWidth = 0.25;
    [self addSubview:_loadingBoard];
    
    UIImageView *logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
    logoImage.image = [[UIImage imageNamed:@"ly_loading"] imageContentWithColor:color];
    logoImage.center = CGPointMake(70, 50);
    [_loadingBoard addSubview:logoImage];
    
    [self startLogoAnim:logoImage];
}

- (void)startLogoAnim:(UIView *)view {
    @weakify(self);
    
    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
    anim.beginTime = CACurrentMediaTime();
    anim.toValue = @(2.0*M_PI);
    anim.duration = 3.0;
    CAMediaTimingFunction * timingfunc = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    anim.timingFunction = timingfunc;
    
    [anim setCompletionBlock:^(POPAnimation *pop, BOOL fint) {
        if (fint) {
            @strongify(self);
            [self startLogoAnim:view];
        }
    }];
    
    [view.layer pop_addAnimation:anim forKey:@"rotationAnimation"];
}

@end
