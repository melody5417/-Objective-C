// ################################################################################//
//		文件名 : QCTabbarController.h
// ################################################################################//
/*!
 @file		QCTabbarController.h
 @brief		作为程序根视图的TabbarController。
 由于程序的根视图是TabbarController，为了支持iOS6的横竖屏唯有自定义一个导航控制器，将“是否支持横竖屏”的代理回调函数写于其中。
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/11/19     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import <UIKit/UIKit.h>

@interface QCTabbarController : UITabBarController

@end
