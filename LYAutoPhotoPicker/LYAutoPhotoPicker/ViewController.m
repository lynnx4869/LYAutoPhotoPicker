//
//  ViewController.m
//  LYAutoPhotoPicker
//
//  Created by xianing on 2017/4/21.
//  Copyright © 2017年 lyning. All rights reserved.
//

#import "ViewController.h"
#import <LYAutoUtil/LYAutoSwitchSheetView.h>
#import "LYAutoPhotoManager.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *displayImage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)chooseImage:(id)sender {
    BOOL isRateTailor = YES;
    double tailoringRate = 1.0;
    NSInteger maxSelects = 5;
    
    [[LYAutoSwitchSheetView shareAutoSwitchSheetView]
     showSheetView:nil
     btns:@[@{@"title": @"相机"}, @{@"title": @"相册"}]
     viewController:self
     btnClick:^(NSString *title) {
         LYAutoPhotoType type;
         if ([title isEqualToString:@"相机"]) {
             type = LYAutoPhotoTypeCamera;
         } else {
             type = LYAutoPhotoTypeAlbum;
         }
         
         LYAutoPhotoManager *manager = [[LYAutoPhotoManager alloc] init];
         manager.isRateTailor = isRateTailor;
         manager.tailoringRate = tailoringRate;
         manager.maxSelects = maxSelects;
         manager.block = ^(BOOL result, NSArray<UIImage *> *images){
             if (result) {
                 self.displayImage.image = [images objectAtIndex:0];
             } else {
                 NSLog(@"cancel...");
             }
         };
         
         manager.type = type;
         [manager checkPhotoAuth:^(UIViewController *vc) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 [self presentViewController:vc animated:YES completion:nil];
             });
         }];
     }];
}

@end
