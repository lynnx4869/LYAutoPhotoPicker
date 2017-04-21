//
//  CameraUtilViewController.m
//  tpsc
//
//  Created by xianing on 2017/2/23.
//  Copyright © 2017年 czcg. All rights reserved.
//

#import "CameraUtilViewController.h"
#import "LY_Consts.h"
#import <AVFoundation/AVFoundation.h>
#import <Masonry.h>
#import <TOCropViewController.h>

@interface CameraUtilViewController () <TOCropViewControllerDelegate>

@property (nonatomic, strong) UIView *cameraView;
@property (nonatomic, strong) UIView *photoView;

@property (nonatomic, strong) AVCaptureDevice *device;
@property (nonatomic, strong) AVCaptureDeviceInput *input;
@property (nonatomic, strong) AVCaptureStillImageOutput *imageOutput;
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) UIImageView *displayImage;

@end

@implementation CameraUtilViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _cameraView = [[UIView alloc] init];
    _cameraView.translatesAutoresizingMaskIntoConstraints = NO;
    _cameraView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_cameraView];
    
    _photoView = [[UIView alloc] init];
    _photoView.translatesAutoresizingMaskIntoConstraints = NO;
    _photoView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_photoView];
    
    UIEdgeInsets padding = UIEdgeInsetsMake(0, 0, 0, 0);
    
    [_cameraView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(padding);
    }];
    
    [_photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(padding);
    }];
    
    _photoView.hidden = YES;
    
    [self cameraInit];
    [self initCameraBtns];
    [self initDisplayImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"alloc...");
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)cameraInit {
    _device = [self cameraOfPosition:AVCaptureDevicePositionBack];
    _input = [[AVCaptureDeviceInput alloc] initWithDevice:_device error:nil];
    
    _imageOutput = [[AVCaptureStillImageOutput alloc] init];
    
    _session = [[AVCaptureSession alloc] init];
    _session.sessionPreset = AVCaptureSessionPreset1920x1080;
    
    if ([_session canAddInput:_input]) {
        [_session addInput:_input];
    }
    
    if ([_session canAddOutput:_imageOutput]) {
        [_session addOutput:_imageOutput];
    }
    
    _previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_session];
    _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _previewLayer.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    [_cameraView.layer addSublayer:_previewLayer];
    
    [_session startRunning];
    
    if ([_device lockForConfiguration:nil]) {
        if ([_device isFlashModeSupported:AVCaptureFlashModeOff]) {
            [_device setFlashMode:AVCaptureFlashModeOff];
        }
        
        if ([_device isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeAutoWhiteBalance]) {
            [_device setWhiteBalanceMode:AVCaptureWhiteBalanceModeAutoWhiteBalance];
        }
        
        [_device unlockForConfiguration];
    }
}

- (void)initCameraBtns {
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [closeBtn setImage:[UIImage imageNamed:@"cross"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeCamera:) forControlEvents:UIControlEventTouchUpInside];
    [_cameraView addSubview:closeBtn];
    
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_cameraView.mas_top).with.offset(15);
        make.left.equalTo(_cameraView.mas_left).with.offset(10);
        make.width.equalTo(@(40));
        make.height.equalTo(@(40));
    }];
    
    UIButton *takePhotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    takePhotoBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [takePhotoBtn setImage:[UIImage imageNamed:@"round"] forState:UIControlStateNormal];
    [takePhotoBtn addTarget:self action:@selector(takePhoto:)
           forControlEvents:UIControlEventTouchUpInside];
    [_cameraView addSubview:takePhotoBtn];
    
    [takePhotoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_cameraView.mas_bottom).with.offset(-10);
        make.centerX.equalTo(_cameraView.mas_centerX);
        make.width.equalTo(@(100));
        make.height.equalTo(@(100));
    }];
    
    UIButton *flashChangeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    flashChangeBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [flashChangeBtn setImage:[UIImage imageNamed:@"flash-off"] forState:UIControlStateNormal];
    [flashChangeBtn addTarget:self action:@selector(changeFlash:)
             forControlEvents:UIControlEventTouchUpInside];
    [_cameraView addSubview:flashChangeBtn];
    
    [flashChangeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_cameraView.mas_top).with.offset(15);
        make.right.equalTo(_cameraView.mas_right).with.offset(-60);
        make.width.equalTo(@(40));
        make.height.equalTo(@(40));
    }];
    
    UIButton *cameraChangeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cameraChangeBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [cameraChangeBtn setImage:[UIImage imageNamed:@"camera-front-on"] forState:UIControlStateNormal];
    [cameraChangeBtn addTarget:self action:@selector(changeCamera:)
             forControlEvents:UIControlEventTouchUpInside];
    [_cameraView addSubview:cameraChangeBtn];
    
    [cameraChangeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_cameraView.mas_top).with.offset(15);
        make.right.equalTo(_cameraView.mas_right).with.offset(-10);
        make.width.equalTo(@(40));
        make.height.equalTo(@(40));
    }];
}

- (void)initDisplayImage {
    _displayImage = [[UIImageView alloc] init];
    _displayImage.translatesAutoresizingMaskIntoConstraints = NO;
    [_photoView addSubview:_displayImage];
    
    UIEdgeInsets padding = UIEdgeInsetsMake(0, 0, 0, 0);
    
    [_displayImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_photoView).with.insets(padding);
    }];
    
    UIButton *takePhotoAgainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    takePhotoAgainBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [takePhotoAgainBtn setTitle:@"重拍" forState:UIControlStateNormal];
    [takePhotoAgainBtn addTarget:self action:@selector(takePhotoAgain:)
                forControlEvents:UIControlEventTouchUpInside];
    [_photoView addSubview:takePhotoAgainBtn];
    
    [takePhotoAgainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_photoView.mas_top).with.offset(15);
        make.left.equalTo(_photoView.mas_left).with.offset(10);
        make.width.equalTo(@(40));
        make.height.equalTo(@(20));
    }];
    
    UIButton *cutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cutBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [cutBtn setImage:[UIImage imageNamed:@"cut"] forState:UIControlStateNormal];
    [cutBtn addTarget:self action:@selector(cutPhoto:)
                forControlEvents:UIControlEventTouchUpInside];
    [_photoView addSubview:cutBtn];
    
    [cutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_photoView.mas_bottom).with.offset(-10);
        make.right.equalTo(_photoView.mas_right).with.offset(-60);
        make.width.equalTo(@(40));
        make.height.equalTo(@(40));
    }];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [sureBtn setImage:[UIImage imageNamed:@"sure"] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(surePhoto:)
                forControlEvents:UIControlEventTouchUpInside];
    [_photoView addSubview:sureBtn];
    
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_photoView.mas_bottom).with.offset(-10);
        make.right.equalTo(_photoView.mas_right).with.offset(-10);
        make.width.equalTo(@(40));
        make.height.equalTo(@(40));
    }];
}

- (AVCaptureDevice *)cameraOfPosition:(AVCaptureDevicePosition)position {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if (device.position == position) {
            return device;
        }
    }
    
    return nil;
}

- (void)closeCamera:(UIButton *)btn {
    self.block(NO, nil);
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)changeCamera:(UIButton *)btn {
    NSUInteger cameraCount = [[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] count];
    if (cameraCount > 1) {
        AVCaptureDevice *newDevice = nil;
        AVCaptureDeviceInput *newInput = nil;
        
        AVCaptureDevicePosition position = [[_input device] position];
        if (position == AVCaptureDevicePositionFront) {
            newDevice = [self cameraOfPosition:AVCaptureDevicePositionBack];
        } else {
            newDevice = [self cameraOfPosition:AVCaptureDevicePositionFront];
        }
        
        newInput = [AVCaptureDeviceInput deviceInputWithDevice:newDevice error:nil];
        if (newInput) {
            [_session beginConfiguration];
            [_session removeInput:_input];
            if ([_session canAddInput:newInput]) {
                [_session addInput:newInput];
                _input = newInput;
            } else {
                [_session addInput:_input];
            }
            [_session commitConfiguration];
        }
    }
}

- (void)changeFlash:(UIButton *)btn {
    if (_device.flashMode == AVCaptureFlashModeOn) {
        [btn setImage:[UIImage imageNamed:@"flash-off"] forState:UIControlStateNormal];
        
        if ([_device lockForConfiguration:nil]) {
            [_device setFlashMode:AVCaptureFlashModeOff];
            
            [_device unlockForConfiguration];
        }
    } else {
        [btn setImage:[UIImage imageNamed:@"flash"] forState:UIControlStateNormal];
        
        if ([_device lockForConfiguration:nil]) {
            [_device setFlashMode:AVCaptureFlashModeOn];
            
            [_device unlockForConfiguration];
        }
    }
}

- (void)takePhoto:(UIButton *)btn {
    AVCaptureConnection *connect = [_imageOutput connectionWithMediaType:AVMediaTypeVideo];
    if (!connect) {
        NSLog(@"error");
        return;
    } else {        
        [_imageOutput captureStillImageAsynchronouslyFromConnection:connect completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
            if (imageDataSampleBuffer == nil) {
                return;
            }
            
            NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
            
            UIImage *image = [[UIImage alloc] initWithData:imageData scale:1.0];
            self.image = image;

            NSLog(@"%lu", imageData.length);
            
            [_session stopRunning];
        }];
    }
}

- (void)setImage:(UIImage *)image {
    _image = image;
    
    if (image) {
        _displayImage.image = image;
        
        _cameraView.hidden = YES;
        _photoView.hidden = NO;
    } else {
        _displayImage.image = nil;
        
        _cameraView.hidden = NO;
        _photoView.hidden = YES;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_session startRunning];
        });
    }
}

- (void)takePhotoAgain:(UIButton *)btn {
    self.image = nil;
}

- (void)cutPhoto:(UIButton *)btn {
    TOCropViewController *tcvc = [[TOCropViewController alloc] initWithImage:_image];
    tcvc.delegate = self;
    tcvc.rotateClockwiseButtonHidden = NO;
    if (self.isRateTailor) {
        tcvc.customAspectRatio = CGSizeMake(self.tailoringRate, 1.0);
        tcvc.aspectRatioLockEnabled = YES;
        tcvc.resetAspectRatioEnabled = NO;
        tcvc.aspectRatioPickerButtonHidden = YES;
    }
    [self presentViewController:tcvc animated:YES completion:nil];
}

- (void)surePhoto:(UIButton *)btn {
    self.block(YES, @[_image]);
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TOCropViewControllerDelegate
- (void)cropViewController:(TOCropViewController *)cropViewController didFinishCancelled:(BOOL)cancelled {
    [cropViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)cropViewController:(TOCropViewController *)cropViewController didCropToImage:(UIImage *)image withRect:(CGRect)cropRect angle:(NSInteger)angle {
    self.image = nil;
    
    self.block(YES, @[image]);
    
    [cropViewController dismissViewControllerAnimated:NO completion:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

@end
