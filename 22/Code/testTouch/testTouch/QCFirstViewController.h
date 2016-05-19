// ################################################################################//
//		文件名 : QCFirstViewController.h
// ################################################################################//
/*!
 @file		QCFirstViewController.h
 @brief		第一个功能视图控制器
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/11/04     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import <UIKit/UIKit.h>

typedef enum GestureType:NSUInteger{
    kTapGesture = 0,
    kPinchGesture,
    kPanGesture,
    kSwipeGesture,
    kRotationGesture,
    kLongPressGesture,
    kGestureSupportingCount,
}GestureType;

@interface QCFirstViewController : UIViewController
@property(nonatomic, retain) IBOutlet UIPickerView      *picker;
@property(nonatomic, retain) IBOutlet UIView            *vGesture;
@property(nonatomic, retain) IBOutlet UIImageView       *imgTest;
@property(nonatomic, retain) IBOutlet UILabel           *labGestureInfo;
@end
