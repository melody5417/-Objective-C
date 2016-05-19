// ################################################################################//
//		文件名 : QCDeleteViewController.h
// ################################################################################//
/*!
 @file		QCDeleteViewController.h
 @brief		删除功能的表视图控制器
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/12/06     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCInfoViewController.h"

@interface QCDeleteViewController : QCInfoViewController
//导航栏上功能按钮
@property(nonatomic, retain) UIBarButtonItem    *editItem;
@property(nonatomic, retain) UIBarButtonItem    *doneItem;
@end
