// ################################################################################//
//		文件名 : QCDatePickerViewController.m
// ################################################################################//
/*!
 @file		QCDatePickerViewController.m
 @brief		日期式样的取值控件
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/09/12     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCDatePickerViewController.h"
@implementation QCDatePickerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //初始化控件内容
    [self actChangeSegment:self.segmentControl];
}

#pragma mark -
#pragma mark Action
- (IBAction)actChangeSegment:(id)sender
{
    //不同的选项，不同的时期取值控件模式
    UISegmentedControl  *seg = (UISegmentedControl*)sender;
    switch (seg.selectedSegmentIndex) {
        case 0:
            self.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
            break;
        case 1:
            self.datePicker.datePickerMode = UIDatePickerModeDate;
            break;
        case 2:
            self.datePicker.datePickerMode = UIDatePickerModeTime;
            break;
        case 3:
            self.datePicker.datePickerMode = UIDatePickerModeCountDownTimer;
            break;
        default:
            break;
    }
    
    //为取值控件赋上当前时间
	self.datePicker.date = [NSDate date];
}

@end
