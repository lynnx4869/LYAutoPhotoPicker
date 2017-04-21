//
//  PhotosViewController.m
//  tpsc
//
//  Created by xianing on 2017/3/8.
//  Copyright © 2017年 czcg. All rights reserved.
//

#import "PhotosViewController.h"
#import "PhotoSelectCell.h"
#import "UIColor+LYUtil.h"
#import "AutoSwitchAlertView.h"
#import <TOCropViewController.h>
#import <MWPhotoBrowser.h>

static const CGFloat kPhotoTumLength = 200;

@interface PhotoAsset : NSObject

@property (nonatomic, strong) PHAsset *asset;
@property (nonatomic, strong) UIImage *image;

@end

@implementation PhotoAsset

@end

@interface PhotoHeaderView : UICollectionReusableView

@end

@implementation PhotoHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

@end

@interface PhotoFooterView : UICollectionReusableView

@property (nonatomic, strong) UILabel *countLabel;

@end

@implementation PhotoFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _countLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.textColor = [UIColor colorWithHex:0xc3c3c3];
        _countLabel.font = [UIFont systemFontOfSize:14.0];
        [self addSubview:_countLabel];
    }
    return self;
}

@end

@interface PhotosViewController ()
    <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, TOCropViewControllerDelegate, ImageCellTapDelegate, MWPhotoBrowserDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray<PhotoAsset *> *photos;
@property (nonatomic, strong) NSMutableArray<PhotoAsset *> *selectPhotos;

@property (nonatomic, strong) UIButton *cutBtn;
@property (nonatomic, strong) UIButton *sureBtn;

@end

@implementation PhotosViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _photos = [NSMutableArray array];
        _selectPhotos = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = _assetCollection.localizedTitle;
    
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                     style:UIBarButtonItemStyleDone
                                    target:self
                                    action:@selector(goBack:)];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [_collectionView registerNib:[UINib nibWithNibName:@"PhotoSelectCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"PhotoSelectCellId"];
    [_collectionView registerClass:[PhotoHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"PhotoHeaderId"];
    [_collectionView registerClass:[PhotoFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"PhotoFooterId"];
    [self.view addSubview:_collectionView];
    
    _collectionView.hidden = YES;
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 44, 0));
    }];
    
    UIView *btnsView = [[UIView alloc] init];
    btnsView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:btnsView];
    
    [btnsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
        make.height.equalTo(@(44));
    }];
    
    UIView *btnsLine = [UIView new];
    btnsLine.backgroundColor = [UIColor colorWithHex:0xeeeeee];
    [btnsView addSubview:btnsLine];
    
    [btnsLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btnsView.mas_left).with.offset(0);
        make.right.equalTo(btnsView.mas_right).with.offset(0);
        make.top.equalTo(btnsView.mas_top).with.offset(0);
        make.height.equalTo(@(1));
    }];
    
    _cutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cutBtn setTitle:@"剪裁" forState:UIControlStateNormal];
    [_cutBtn setTitle:@"剪裁" forState:UIControlStateDisabled];
    [_cutBtn setTitleColor:MainColor forState:UIControlStateNormal];
    [_cutBtn setTitleColor:[UIColor colorWithHex:0xcccccc] forState:UIControlStateDisabled];
    [_cutBtn setBackgroundColor:[UIColor colorWithHex:0xffffff]];
    [_cutBtn addTarget:self action:@selector(cutPhoto:) forControlEvents:UIControlEventTouchUpInside];
    [btnsView addSubview:_cutBtn];
    
    [_cutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btnsView.mas_left).with.offset(0);
        make.centerY.equalTo(btnsView.mas_centerY).with.offset(0);
        make.height.equalTo(@(40));
        make.width.equalTo(@(60));
    }];
    
    [_cutBtn setEnabled:NO];
    
    _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_sureBtn setTitle:@"确认" forState:UIControlStateNormal];
    [_sureBtn setTitle:@"确认" forState:UIControlStateDisabled];
    [_sureBtn setTitleColor:MainColor forState:UIControlStateNormal];
    [_sureBtn setTitleColor:[UIColor colorWithHex:0xcccccc] forState:UIControlStateDisabled];
    [_sureBtn setBackgroundColor:[UIColor colorWithHex:0xffffff]];
    [_sureBtn addTarget:self action:@selector(sureSelect:) forControlEvents:UIControlEventTouchUpInside];
    [btnsView addSubview:_sureBtn];
    
    [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(btnsView.mas_right).with.offset(0);
        make.centerY.equalTo(btnsView.mas_centerY).with.offset(0);
        make.height.equalTo(@(40));
        make.width.equalTo(@(60));
    }];
    
    [_sureBtn setEnabled:NO];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:_assetCollection options:nil];
        for (PHAsset *asset in assets) {
            PhotoAsset *photoAsset = [[PhotoAsset alloc] init];
            photoAsset.asset = asset;
            [_photos addObject:photoAsset];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_collectionView reloadData];
        });
        
        dispatch_async(dispatch_get_main_queue(), ^{
            CGFloat yOffset = 0;
            if (_collectionView.contentSize.height > _collectionView.bounds.size.height) {
                yOffset = _collectionView.contentSize.height - _collectionView.bounds.size.height;
            }
            
            [_collectionView setContentOffset:CGPointMake(0, yOffset) animated:NO];
            
            _collectionView.hidden = NO;
        });
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"photo view controller dealloc");
}

- (void)goBack:(UIBarButtonItem *)item {
    self.block(NO, nil);

    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)cutPhoto:(UIButton *)btn {
    PHAsset *asset = _selectPhotos.firstObject.asset;
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.synchronous = YES;
    
    [[PHImageManager defaultManager] requestImageForAsset:asset
                                               targetSize:CGSizeMake(asset.pixelWidth, asset.pixelHeight)
                                              contentMode:PHImageContentModeDefault
                                                  options:options
                                            resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                                                TOCropViewController *tcvc = [[TOCropViewController alloc] initWithImage:result];
                                                tcvc.delegate = self;
                                                tcvc.rotateClockwiseButtonHidden = NO;
                                                if (self.isRateTailor) {
                                                    tcvc.customAspectRatio = CGSizeMake(self.tailoringRate, 1.0);
                                                    tcvc.aspectRatioLockEnabled = YES;
                                                    tcvc.resetAspectRatioEnabled = NO;
                                                    tcvc.aspectRatioPickerButtonHidden = YES;
                                                }
                                                [self presentViewController:tcvc animated:YES completion:nil];
                                            }];
}

- (void)sureSelect:(UIButton *)btn {
    NSMutableArray<UIImage *> *array = [NSMutableArray array];
    for (PhotoAsset *asset in _selectPhotos) {
        [array addObject:asset.image];
    }
    
    self.block(YES, array);
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)tapImage:(id)sender index:(NSInteger)index {
    PhotoAsset *photoAsset = [_photos objectAtIndex:index];
    
    if ([_selectPhotos containsObject:photoAsset]) {
        [_selectPhotos removeObject:photoAsset];
    } else {
        if (_selectPhotos.count == _maxSelects && _maxSelects != 0) {
            [[AutoSwitchAlertView shareAutoSwitchAlertView] showAlertView:@"提示"
                                                                  subText:[NSString stringWithFormat:@"最多只能选择%ld张照片", _maxSelects]
                                                               isJudgment:NO
                                                           viewController:self
                                                                sureClick:^(NSString *title) {
                                                                    
                                                                }
                                                              cancelBlock:^(NSString *title) {
                                                                  
                                                              }];
            
            return;
        }
        
        [_selectPhotos addObject:photoAsset];
    }
    
    if (_selectPhotos.count == 1) {
        [_cutBtn setEnabled:YES];
    } else {
        [_cutBtn setEnabled:NO];
    }
    
    if (_selectPhotos.count > 0) {
        [_sureBtn setEnabled:YES];
    } else {
        [_sureBtn setEnabled:NO];
    }
    
    [_collectionView reloadData];
}

#pragma mark - TOCropViewControllerDelegate
- (void)cropViewController:(TOCropViewController *)cropViewController didFinishCancelled:(BOOL)cancelled {
    [cropViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)cropViewController:(TOCropViewController *)cropViewController didCropToImage:(UIImage *)image withRect:(CGRect)cropRect angle:(NSInteger)angle {
    self.block(YES, @[image]);
    
    [cropViewController dismissViewControllerAnimated:NO completion:^{
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }];
}

#pragma mark - MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser{
    return _photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count) {
        PhotoAsset *photoAsset = [_photos objectAtIndex:index];
        
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        options.synchronous = YES;
        CGSize size = CGSizeMake(photoAsset.asset.pixelWidth, photoAsset.asset.pixelHeight);
        
        __block UIImage *image = nil;
        [[PHImageManager defaultManager] requestImageForAsset:photoAsset.asset
                                                   targetSize:size
                                                  contentMode:PHImageContentModeDefault
                                                      options:options
                                                resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                                                    image = result;
                                                }];
        return [MWPhoto photoWithImage:image];
    }
    
    return nil;
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _photos.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (ScreenWidth - 15) / 4;
    return CGSizeMake(width, width);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoSelectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoSelectCellId" forIndexPath:indexPath];
    
    cell.delegate = self;
    cell.currentIndex = indexPath.item;
    
    PhotoAsset *photoAsset = [_photos objectAtIndex:indexPath.item];
    
    if (photoAsset.image) {
        cell.tumImage.image = photoAsset.image;
    } else {
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        options.synchronous = YES;
        CGSize size = CGSizeZero;
        if (photoAsset.asset.pixelWidth > kPhotoTumLength) {
            size = CGSizeMake(kPhotoTumLength, kPhotoTumLength*photoAsset.asset.pixelHeight/photoAsset.asset.pixelWidth);
        } else if (photoAsset.asset.pixelHeight > kPhotoTumLength) {
            size = CGSizeMake(kPhotoTumLength*photoAsset.asset.pixelWidth/photoAsset.asset.pixelHeight, kPhotoTumLength);
        } else {
            size = CGSizeMake(photoAsset.asset.pixelWidth, photoAsset.asset.pixelHeight);
        }
        
        [[PHImageManager defaultManager] requestImageForAsset:photoAsset.asset
                                                   targetSize:size
                                                  contentMode:PHImageContentModeDefault
                                                      options:options
                                                resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                                                    photoAsset.image = result;
                                                    cell.tumImage.image = result;
                                                }];
    }
    
    if ([_selectPhotos containsObject:photoAsset]) {
        cell.selectTag.text = [NSString stringWithFormat:@"%ld", [_selectPhotos indexOfObject:photoAsset]+1];
        cell.selectTag.backgroundColor = [UIColor colorWithHex:0x1296DB];
    } else {
        cell.selectTag.text = @"";
        cell.selectTag.backgroundColor = [UIColor colorWithHex:0xffffff alpha:0.3];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    
    // Set options
    browser.displayActionButton = NO;
    browser.displayNavArrows = NO;
    browser.displaySelectionButtons = NO;
    browser.zoomPhotosToFill = YES;
    browser.alwaysShowControls = NO;
    browser.enableGrid = YES;
    browser.startOnGrid = NO;
    browser.autoPlayOnAppear = NO;
    
    [browser setCurrentPhotoIndex:indexPath.item];
    [browser showNextPhotoAnimated:YES];
    [browser showPreviousPhotoAnimated:YES];
    
    [self.navigationController pushViewController:browser animated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(ScreenWidth, 5);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(ScreenWidth, 30);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *supplementaryView;
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        PhotoHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"PhotoHeaderId" forIndexPath:indexPath];
        supplementaryView = headerView;
    }
    
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        PhotoFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"PhotoFooterId" forIndexPath:indexPath];
        footerView.countLabel.text = [NSString stringWithFormat:@"共%ld张照片", _photos.count];
        supplementaryView = footerView;
    }
    
    return supplementaryView;
}


@end
