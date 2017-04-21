//
//  AlbumsViewController.m
//  tpsc
//
//  Created by xianing on 2017/3/8.
//  Copyright © 2017年 czcg. All rights reserved.
//

#import "AlbumsViewController.h"
#import "AlbumDisplayCell.h"
#import "PhotosViewController.h"

static const CGFloat kAblumLength = 200;

@interface AlbumsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray<PHAssetCollection *> *array;

@property (nonatomic, strong) PHAssetCollection *userLibrary;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation AlbumsViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _array = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[UINib nibWithNibName:@"AlbumDisplayCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"AlbumDisplayCellId"];
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        PHFetchResult<PHAssetCollection *> *sysAssetCollections =
        [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum
                                                 subtype:PHAssetCollectionSubtypeAny
                                                 options:nil];
        
        for (PHAssetCollection *assetCollection in sysAssetCollections) {
            PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
            
            if (assets.count != 0) {
                [_array addObject:assetCollection];
            }
            
            if (assetCollection.assetCollectionSubtype == PHAssetCollectionSubtypeSmartAlbumUserLibrary) {
                _userLibrary = assetCollection;
            }
        }
        
        PHFetchResult<PHAssetCollection *> *userAssetCollections =
        [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum
                                                 subtype:PHAssetCollectionSubtypeAlbumRegular
                                                 options:nil];
        
        for (PHAssetCollection *assetCollection in userAssetCollections) {
            PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
            
            if (assets.count != 0) {
                [_array addObject:assetCollection];
            }
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            PhotosViewController *pvc = [[PhotosViewController alloc] init];
            pvc.assetCollection = _userLibrary;
            pvc.maxSelects = _maxSelects;
            pvc.block = self.block;
            pvc.isRateTailor = self.isRateTailor;
            pvc.tailoringRate = self.tailoringRate;
            [self.navigationController pushViewController:pvc animated:NO];
            
            self.navigationItem.title = @"照片";
            self.navigationItem.rightBarButtonItem =
            [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                             style:UIBarButtonItemStyleDone
                                            target:self
                                            action:@selector(goBack:)];
            
            [_tableView reloadData];
        });
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"albums view controller dealloc");
}

- (void)goBack:(UIBarButtonItem *)item {
    self.block(NO, nil);
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AlbumDisplayCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AlbumDisplayCellId"];
    
    PHAssetCollection *assetCollection = [_array objectAtIndex:indexPath.row];;
    
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    cell.albumTitle.text = assetCollection.localizedTitle;
    cell.albumCount.text = [NSString stringWithFormat:@"(%ld)", assets.count];
    
    PHAsset *asset = assets.lastObject;
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.synchronous = YES;
    CGSize size = CGSizeZero;
    if (asset.pixelWidth > kAblumLength) {
        size = CGSizeMake(kAblumLength, kAblumLength*asset.pixelHeight/asset.pixelWidth);
    } else if (asset.pixelHeight > kAblumLength) {
        size = CGSizeMake(kAblumLength*asset.pixelWidth/asset.pixelHeight, kAblumLength);
    } else {
        size = CGSizeMake(asset.pixelWidth, asset.pixelHeight);
    }
    
    [[PHImageManager defaultManager] requestImageForAsset:asset
                                               targetSize:size
                                              contentMode:PHImageContentModeDefault
                                                  options:options
                                            resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                                                cell.albumImage.image = result;
                                            }];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PHAssetCollection *assetCollection = [_array objectAtIndex:indexPath.row];
    
    PhotosViewController *pvc = [[PhotosViewController alloc] init];
    pvc.assetCollection = assetCollection;
    pvc.maxSelects = _maxSelects;
    pvc.block = self.block;
    pvc.isRateTailor = self.isRateTailor;
    pvc.tailoringRate = self.tailoringRate;
    [self.navigationController pushViewController:pvc animated:YES];
}

@end
