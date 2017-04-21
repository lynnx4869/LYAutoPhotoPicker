//
//  LYAutoDatePickerController.m
//  LYAutoUtil
//
//  Created by xianing on 2017/4/21.
//  Copyright © 2017年 lyning. All rights reserved.
//

#import "LYAutoDatePickerController.h"

@interface LYAutoDatePickerController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation LYAutoDatePickerController

+ (instancetype)createPicker:(NSTimeInterval)time max:(NSTimeInterval)maxTime min:(NSTimeInterval)minTime sureBlock:(SurePickBlock)block {
    LYAutoDatePickerController *adp = [[LYAutoDatePickerController alloc] initWithNibName:@"LYAutoDatePickerController" bundle:nil];
    
    adp.times = time;
    adp.maxTime = maxTime;
    adp.minTime = minTime;
    adp.block = block;
    
    return adp;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _times = [[NSDate date] timeIntervalSince1970] * 1000;
    }
    return self;
}

- (void)setCurrentTime:(NSTimeInterval)time {
    if (time != 0) {
        _datePicker.date = [NSDate dateWithTimeIntervalSince1970:time/1000];
    }
}

- (void)setMaxDate:(NSTimeInterval)maxTime {
    if (maxTime != 0) {
        _datePicker.maximumDate = [NSDate dateWithTimeIntervalSince1970:maxTime/1000];
    }
}

- (void)setMinDate:(NSTimeInterval)minTime {
    if (minTime != 0) {
        _datePicker.minimumDate = [NSDate dateWithTimeIntervalSince1970:minTime/1000];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setCurrentTime:_times];
    [self setMaxDate:_maxTime];
    [self setMinDate:_minTime];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    NSLog(@"Auto Date Picker dealloc");
}

- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)sureAction:(id)sender {
    self.block(_times);
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)datepickerChange:(id)sender {
    _times = [_datePicker.date timeIntervalSince1970] * 1000;
}

@end
