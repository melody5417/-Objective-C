// ################################################################################//
//		文件名 : AppDelegate.h
// ################################################################################//
/*!
 @file		AppDelegate.h
 @brief		应用代理类头文件
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/08/28     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

- (IBAction)actShowQuickAlert:(id)sender;
- (IBAction)actShowNormalAlert1:(id)sender;
- (IBAction)actShowNormalAlert2:(id)sender;
- (IBAction)actShowNormalAlert3:(id)sender;
- (IBAction)actShowAlertSheet:(id)sender;
- (IBAction)actShowAccessoryAlert:(id)sender;
- (IBAction)actShowCheckBoxAlert:(id)sender;

- (IBAction)actShowSheet:(id)sender;

@end
