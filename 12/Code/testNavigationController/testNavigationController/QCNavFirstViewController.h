// ################################################################################//
//		文件名 : QCNavFirstViewController.h
// ################################################################################//
/*!
 @file		QCNavFirstViewController.h
 @brief		导航控制器中位于根视图之后的首个视图控制器头文件
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/11/17     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import <UIKit/UIKit.h>

@interface QCNavFirstViewController : UIViewController
{
    //位于导航栏上的分段控件
    UISegmentedControl  *_mySegments;
    
    //工具栏内容
    NSArray             *_toolBarItems;
}

@end
