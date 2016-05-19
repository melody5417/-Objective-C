// ################################################################################//
//		文件名 : QCAlertUtility.h
// ################################################################################//
/*!
 @file		QCAlertUtility.h
 @brief		Alert类型的警告框
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/08/27     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import <UIKit/UIKit.h>

typedef enum AlertType{
    kAlertNormalType,
    kAlertUseDelegateType,
    kAlertNoButtonType,
    kAlertBlockType,
    kAlertTextInputType,
    kAlertTextInputType5,
    kAlertTextSecureInputType5,
    kAlertLoginType5,
    kAlertFormatType,
    kAlertTypeCount
}AlertTypeEnum;

@interface QCAlertUtility : NSObject<UIAlertViewDelegate>
{
    CFRunLoopRef    _currentLoop;
    NSString        *_strMsg;
}

+ (id)defaultAlert;

+ (void)showNormalAlert;
- (void)showDelegateAlert;
- (void)showNoButtonAlert;
- (void)showBlockAlert;

- (void)showTextInputAlert;
- (void)showTextInputIOS5Alert;
- (void)showSecureTextInputIOS5Alert;
- (void)showLoginIOS5Alert;
- (void)showFormatTypeAlert:(NSString *)format, ...;

@end
