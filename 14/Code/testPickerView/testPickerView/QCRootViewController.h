// ################################################################################//
//		文件名 : QCRootViewController.h
// ################################################################################//
/*!
 @file		QCRootViewController.h
 @brief		作为程序根视图“导航控制器”的根视图类
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/09/12     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import <UIKit/UIKit.h>

@interface QCRootViewController : UIViewController
//界面上的三个按钮
//进入三种“取值控件”模式
- (IBAction)actSimplePickerView:(id)sender;
- (IBAction)actDatePickerView:(id)sender;
- (IBAction)actCustomizePickerView:(id)sender;
@end
