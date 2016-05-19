// ################################################################################//
//		文件名 : QCNavControllerViewController.h
// ################################################################################//
/*!
 @file		QCNavControllerViewController.h
 @brief		作为程序根视图控制器的导航控制器。
            由于程序的根视图是导航控制器，为了支持iOS6的横竖屏唯有自定义一个导航控制器，将“是否支持横竖屏”的代理回调函数写于其中。
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/09/12     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import <UIKit/UIKit.h>

@interface QCNavControllerViewController : UINavigationController
@end
