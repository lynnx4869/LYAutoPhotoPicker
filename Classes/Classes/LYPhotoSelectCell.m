//
//  LYPhotoSelectCell.m
//  LYAutoPhotoPicker
//
//  Created by xianing on 2017/4/21.
//  Copyright © 2017年 lyning. All rights reserved.
//

#import "LYPhotoSelectCell.h"

@implementation LYPhotoSelectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectTag.layer.masksToBounds = YES;
    self.selectTag.layer.cornerRadius = 10.0;
    self.selectTag.layer.borderWidth = 1.0;
    self.selectTag.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.selectTagBg.userInteractionEnabled = YES;
    
    [self.selectTagBg addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectImageTag:)]];
}

- (void)selectImageTag:(UITapGestureRecognizer *)tap {
    [_delegate tapImage:tap.view index:_currentIndex];
}

@end
