//
//  LYAutoPhotoAuthErrorViewController.m
//  LYAutoPhotoPicker
//
//  Created by xianing on 2017/4/21.
//  Copyright © 2017年 lyning. All rights reserved.
//

#import "LYAutoPhotoAuthErrorViewController.h"

@interface LYAutoPhotoAuthErrorViewController ()

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *linkLabel;

@end

@implementation LYAutoPhotoAuthErrorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    switch (_type) {
            case LYAutoPhotoTypeCamera:
            self.navigationItem.title = @"相机";
            self.messageLabel.text = @"此应用程序没有权限访问您的相机";
            self.linkLabel.text = @"在“设置-隐私-相机”中开启即可使用";
            break;
            case LYAutoPhotoTypeAlbum:
            self.navigationItem.title = @"照片";
            self.messageLabel.text = @"此应用程序没有权限访问您的照片";
            self.linkLabel.text = @"在“设置-隐私-照片”中开启即可查看";
            break;
        default:
            break;
    }
    
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                     style:UIBarButtonItemStyleDone
                                    target:self
                                    action:@selector(goBack:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)goBack:(UIBarButtonItem *)item {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)settingAuth:(UIButton *)sender {
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 10.0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    } else {
        NSURL *url = nil;
        switch (_type) {
                case LYAutoPhotoTypeCamera: {
                    url = [NSURL URLWithString:@"Prefs:root=Privacy&path=CAMERA"];
                    break;
                }
                case LYAutoPhotoTypeAlbum: {
                    url = [NSURL URLWithString:@"Prefs:root=Privacy&path=PHOTOS"];
                    break;
                }
            default:
                break;
        }
        
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

@end
