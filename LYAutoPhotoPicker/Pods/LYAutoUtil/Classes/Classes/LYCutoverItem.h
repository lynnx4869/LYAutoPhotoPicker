//
//  LYCutoverItem.h
//  LYAutoUtil
//
//  Created by xianing on 2017/4/21.
//  Copyright © 2017年 lyning. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LYCutoverItemDelegate <NSObject>

@required
- (void)cutoverItemCallback:(NSInteger)index;

@end

@interface LYCutoverItem : UIView

@property (nonatomic, strong) UIColor *mainColor;

@property (nonatomic, weak) id<LYCutoverItemDelegate> delegate;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, assign) BOOL isSelect;

@end
