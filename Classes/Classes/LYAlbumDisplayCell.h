//
//  LYAlbumDisplayCell.h
//  LYAutoPhotoPicker
//
//  Created by xianing on 2017/4/21.
//  Copyright © 2017年 lyning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYAlbumDisplayCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *albumImage;
@property (weak, nonatomic) IBOutlet UILabel *albumTitle;
@property (weak, nonatomic) IBOutlet UILabel *albumCount;

@end
