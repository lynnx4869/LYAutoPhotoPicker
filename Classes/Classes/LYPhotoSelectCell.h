//
//  LYPhotoSelectCell.h
//  LYAutoPhotoPicker
//
//  Created by xianing on 2017/4/21.
//  Copyright © 2017年 lyning. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LYImageCellTapDelegate <NSObject>

@required
- (void)tapImage:(id)sender index:(NSInteger)index;

@end

@interface LYPhotoSelectCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *tumImage;
@property (weak, nonatomic) IBOutlet UILabel *selectTag;
@property (weak, nonatomic) IBOutlet UIView *selectTagBg;

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, weak) id<LYImageCellTapDelegate> delegate;

@end
