// ################################################################################//
//		文件名 : QCViewController.h
// ################################################################################//
/*!
 @file		QCViewController.h
 @brief		显示视图类
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/12/10     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*

#import <UIKit/UIKit.h>

@interface QCViewController : UIViewController
@property (nonatomic, retain) IBOutlet UITextView *textView;

-(void)printLog:(NSString*)aNewLog;
@end
