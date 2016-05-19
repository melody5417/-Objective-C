// ################################################################################//
//		文件名 : QCAppDelegate.h
// ################################################################################//
/*!
 @file		QCAppDelegate.h
 @brief		应用代理类头文件
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/11/19     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import <UIKit/UIKit.h>
#import "QCTabbarController.h"

@interface QCAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow              *window;
@property (strong, nonatomic) QCTabbarController    *tabBarController;

@end
