// ################################################################################//
//		文件名 : QCIndexedTableViewController.h
// ################################################################################//
/*!
 @file		QCIndexedTableViewController.h
 @brief		索引的表视图控制器
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/12/04     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCSectionTableViewController.h"

@interface QCIndexedTableViewController : QCSimpleTableViewController {
    //既表示每段的段名，也表示索引表的内容
    NSArray *_indexTitles;
}
@end
