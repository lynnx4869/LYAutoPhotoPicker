//
//  AlbumDisplayCell.h
//  tpsc
//
//  Created by xianing on 2017/3/8.
//  Copyright © 2017年 czcg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumDisplayCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *albumImage;
@property (weak, nonatomic) IBOutlet UILabel *albumTitle;
@property (weak, nonatomic) IBOutlet UILabel *albumCount;

@end
