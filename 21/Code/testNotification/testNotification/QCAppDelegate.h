// ################################################################################//
//		文件名 : QCAppDelegate.h
// ################################################################################//
/*!
 @file		QCAppDelegate.h
 @brief		应用代理类实现文件
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/11/04     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import <UIKit/UIKit.h>

@class QCViewController;
@interface QCAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow          *window;
@property (strong, nonatomic) QCViewController  *viewController;

@end
