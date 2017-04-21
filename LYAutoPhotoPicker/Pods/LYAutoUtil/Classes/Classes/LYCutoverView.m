//
//  LYCutoverView.m
//  LYAutoUtil
//
//  Created by xianing on 2017/4/21.
//  Copyright © 2017年 lyning. All rights reserved.
//

#import "LYCutoverView.h"
#import "LYCutoverItem.h"
#import "UIColor+LYUtil.h"
#import "LYAutoUtil_Consts.h"

@interface LYCutoverView () <LYCutoverItemDelegate>

@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, strong) UIView *lineView;

@end

@implementation LYCutoverView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _items = [NSMutableArray array];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _items = [NSMutableArray array];
    }
    return self;
}

- (void)setTitles:(NSArray<NSString *> *)titles {
    if (titles.count != 0) {
        _titles = titles;
        
        if (titles.count == _items.count) {
            [_items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                LYCutoverItem *item = obj;
                item.title = [titles objectAtIndex:idx];
            }];
        } else {
            [_items removeAllObjects];
            
            for(UIView *view in self.subviews){
                [view removeFromSuperview];
            }
            
            CGFloat width = ScreenWidth / titles.count;
            for (NSInteger i = 0; i < titles.count; i++) {
                LYCutoverItem *item = [[LYCutoverItem alloc] initWithFrame:CGRectMake(i*width, 0, width, 40)];
                item.mainColor = _mainColor;
                item.title = titles[i];
                item.index = i;
                item.isSelect = NO;
                item.delegate = self;
                [self addSubview:item];
                
                [_items addObject:item];
                
                if (i) {
                    UIView *cutLine = [[UIView alloc] initWithFrame:CGRectMake(i*width, 5, 1, 30)];
                    cutLine.backgroundColor = [UIColor colorWithHex:0xebebeb];
                    [self addSubview:cutLine];
                }
            }
            
            _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 38, width, 2)];
            _lineView.backgroundColor = _mainColor;
            [self addSubview:_lineView];
        }
    }
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    
    for (LYCutoverItem *item in _items) {
        if (item.index == currentIndex) {
            item.isSelect = YES;
        } else {
            item.isSelect = NO;
        }
    }
    
    @weakify(self);
    CGFloat width = ScreenWidth / _titles.count;
    
    [UIView animateWithDuration:0.5 animations:^{
        @strongify(self);
        
        self.lineView.frame = CGRectMake(currentIndex*width, 38, width, 2);
    }];
}

- (void)cutoverItemCallback:(NSInteger)index {
    self.clickBlock(index);
    
    self.currentIndex = index;
}

@end
