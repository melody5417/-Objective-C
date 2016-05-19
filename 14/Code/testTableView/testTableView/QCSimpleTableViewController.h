// ################################################################################//
//		文件名 : RMPlayerDM.h
// ################################################################################//
/*!
 @file		RMPlayerDM.h
 @brief		Real Madrid球队球员的Data Model
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/12/04     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import <UIKit/UIKit.h>

@interface RMPlayerDM : NSObject

@property(nonatomic, retain) NSString  *name;
@property(nonatomic, retain) NSNumber  *number;
@property(nonatomic, retain) NSString  *role;

@end

// ################################################################################//
//		文件名 : QCSimpleTableViewController.h
// ################################################################################//
/*!
 @file		QCSimpleTableViewController.h
 @brief		最基本最简单的表视图控制器
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/12/04     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
@interface QCSimpleTableViewController : UITableViewController
{
    //@property变量的数据源考虑到规范性，只提供外部只读权限。
    //所以这里声明一个成员变量的数据源对象，方便开发之用
    NSArray *_datasource;
}

@property(nonatomic, readonly, retain) NSArray  *datasource;

//数据源赋值
- (void)initData;
//界面配置
- (void)initUI;
//视图控制器的标题
- (NSString*)title;

@end
