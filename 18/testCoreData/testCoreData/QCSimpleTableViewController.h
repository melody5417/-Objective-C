// ################################################################################//
//		文件名 : QCSimpleTableViewController.h
// ################################################################################//
/*!
 @file		QCSimpleTableViewController.h
 @brief		表视图控制器
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/09/10     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "QCDetailedViewController.h"

@class QCDBManager;
@interface QCSimpleTableViewController : UITableViewController<NSFetchedResultsControllerDelegate, DetailedViewControllerDelegate>
{
    QCDBManager                 *_dbManager;
    NSIndexPath                 *_selectedIndexPath;
}

@property(nonatomic, retain)            UIBarButtonItem             *deleteItem;
@property(nonatomic, retain)            UIBarButtonItem             *insertItem;
@property(nonatomic, retain)            UIBarButtonItem             *doneItem;
@property(nonatomic, retain)            NSFetchedResultsController  *fetchedResults;

//数据源赋值
- (void)initData;
//界面配置
- (void)initUI;

@end
