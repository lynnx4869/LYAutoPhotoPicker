//
//  AlbumDisplayCell.m
//  tpsc
//
//  Created by xianing on 2017/3/8.
//  Copyright © 2017年 czcg. All rights reserved.
//

#import "AlbumDisplayCell.h"

@implementation AlbumDisplayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
