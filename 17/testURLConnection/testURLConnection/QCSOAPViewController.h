// ################################################################################//
//		文件名 : QCSOAPViewController.h
// ################################################################################//
/*!
 @file		QCSOAPViewController.h
 @brief		SOAP方法网络连接视图控制器
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/09/16     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import <UIKit/UIKit.h>

@interface QCSOAPViewController : UIViewController

@property (nonatomic, retain) IBOutlet UITextView   *forcasInfo;
@property (nonatomic, retain) IBOutlet UIButton     *shanghaiForcast;

- (IBAction)weatherForcast:(id)sender;

@end
