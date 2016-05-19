// ################################################################################//
//		文件名 : QCTestViewController.h
// ################################################################################//
/*!
 @file		QCTestViewController.h
 @brief		TabbarController的第四个开始的之后所有视图控制器：“随机内容颜色视图”
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/11/19     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import <UIKit/UIKit.h>

@interface QCTestViewController : UIViewController

//自定义初始化接口
//用于使用外部传入的标题
- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
                title:(NSString*)title;

@end
