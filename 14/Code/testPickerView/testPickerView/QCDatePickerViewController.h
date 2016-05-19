// ################################################################################//
//		文件名 : QCDatePickerViewController.h
// ################################################################################//
/*!
 @file		QCDatePickerViewController.h
 @brief		日期式样的取值控件
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/09/12     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import <UIKit/UIKit.h>

@interface QCDatePickerViewController : UIViewController

@property(nonatomic, readonly, retain) IBOutlet UIDatePicker            *datePicker;
@property(nonatomic, readonly, retain) IBOutlet UISegmentedControl      *segmentControl;

- (IBAction)actChangeSegment:(id)sender;
@end
