// ################################################################################//
//		文件名 :QCMoveViewController.h
// ################################################################################//
/*!
 @file		QCMoveViewController.h
 @brief		排序功能的表视图控制器
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/12/06     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCInfoViewController.h"

@interface QCMoveViewController : QCInfoViewController

@property(nonatomic, retain) UIBarButtonItem    *orderItem;
@property(nonatomic, retain) UIBarButtonItem    *doneItem;

@end
