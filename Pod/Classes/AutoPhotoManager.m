//
//  AutoPhotoManager.m
//  tpsc
//
//  Created by xianing on 2017/3/12.
//  Copyright © 2017年 czcg. All rights reserved.
//

#import "AutoPhotoManager.h"
#import <Photos/Photos.h>

@implementation AutoPhotoManager

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
        case AutoPhotoTypeCamera: {
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
        case AutoPhotoTypeAlbum: {
            PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
            
            if (authStatus == PHAuthorizationStatusNotDetermined) {
                [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                    if (authStatus == PHAuthorizationStatusDenied) {
                        block([self getErrorController]);
                    } else if (authStatus == PHAuthorizationStatusAuthorized) {
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
    AutoPhotoAuthErrorViewController *apaevc = [[AutoPhotoAuthErrorViewController alloc] initWithNibName:@"AutoPhotoAuthErrorViewController" bundle:[NSBundle mainBundle]];
    apaevc.type = self.type;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:apaevc];
    nav.navigationBar.translucent = NO;
    
    return nav;
}

- (UIViewController *)getDefaultController {
    UIViewController *vc = nil;
    
    switch (_type) {
        case AutoPhotoTypeCamera: {
            CameraUtilViewController *cuvc = [[CameraUtilViewController alloc] init];
            cuvc.isRateTailor = self.isRateTailor;
            cuvc.tailoringRate = self.tailoringRate;
            cuvc.block = self.block;
            vc = cuvc;
            break;
        }
        case AutoPhotoTypeAlbum: {
            AlbumsViewController *avc = [[AlbumsViewController alloc] init];
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
