//
//  PhotoSelectCell.h
//  tpsc
//
//  Created by xianing on 2017/3/8.
//  Copyright © 2017年 czcg. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImageCellTapDelegate <NSObject>

@required
- (void)tapImage:(id)sender index:(NSInteger)index;

@end

@interface PhotoSelectCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *tumImage;
@property (weak, nonatomic) IBOutlet UILabel *selectTag;
@property (weak, nonatomic) IBOutlet UIView *selectTagBg;

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, weak) id<ImageCellTapDelegate> delegate;

@end
