//
//  LYAutoPhotoManager.m
//  LYAutoPhotoPicker
//
//  Created by xianing on 2017/4/21.
//  Copyright © 2017年 lyning. All rights reserved.
//

#import "LYAutoPhotoManager.h"
#import <Photos/Photos.h>

@implementation LYAutoPhotoManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isRateTailor = NO;
        _tailoringRate = 0;
        _maxSelects = 1;
    }
    return self;
}

- (void)checkPhotoAuth:(CheckAuthBlock)block {
    switch (_type) {
        case LYAutoPhotoTypeCamera: {
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            
            if (authStatus == AVAuthorizationStatusNotDetermined) {
                [AVCaptureDevice
                 requestAccessForMediaType:AVMediaTypeVideo
                 completionHandler:^(BOOL granted) {
                     if (granted) {
                         block([self getDefaultController]);
                     } else {
                         block([self getErrorController]);
                     }
                 }];
            } else if (authStatus == AVAuthorizationStatusDenied) {
                block([self getErrorController]);
            } else if (authStatus == AVAuthorizationStatusAuthorized) {
                block([self getDefaultController]);
            }
            
            break;
        }
        case LYAutoPhotoTypeAlbum: {
            PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
            
            if (authStatus == PHAuthorizationStatusNotDetermined) {
                [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                    if (status == PHAuthorizationStatusDenied) {
                        block([self getErrorController]);
                    } else if (status == PHAuthorizationStatusAuthorized) {
                        block([self getDefaultController]);
                    }
                }];
            } else if (authStatus == PHAuthorizationStatusDenied) {
                block([self getErrorController]);
            } else if (authStatus == PHAuthorizationStatusAuthorized) {
                block([self getDefaultController]);
            }
            
            break;
        }
        default:
            break;
    }
}

- (UIViewController *)getErrorController {
    LYAutoPhotoAuthErrorViewController *apaevc = [[LYAutoPhotoAuthErrorViewController alloc] initWithNibName:@"LYAutoPhotoAuthErrorViewController" bundle:[NSBundle mainBundle]];
    apaevc.type = self.type;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:apaevc];
    nav.navigationBar.translucent = NO;
    
    return nav;
}

- (UIViewController *)getDefaultController {
    UIViewController *vc = nil;
    
    switch (_type) {
            case LYAutoPhotoTypeCamera: {
                LYCameraUtilViewController *cuvc = [[LYCameraUtilViewController alloc] init];
                cuvc.isRateTailor = self.isRateTailor;
                cuvc.tailoringRate = self.tailoringRate;
                cuvc.block = self.block;
                vc = cuvc;
                break;
            }
            case LYAutoPhotoTypeAlbum: {
                LYAlbumsViewController *avc = [[LYAlbumsViewController alloc] init];
                avc.isRateTailor = self.isRateTailor;
                avc.tailoringRate = self.tailoringRate;
                avc.block = self.block;
                avc.maxSelects = self.maxSelects;
                
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:avc];
                nav.navigationBar.translucent = NO;
                vc = nav;
                break;
            }
        default:
            break;
    }
    
    return vc;
}

@end
