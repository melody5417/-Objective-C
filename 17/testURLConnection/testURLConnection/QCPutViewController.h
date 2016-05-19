// ################################################################################//
//		文件名 : QCPutViewController.h
// ################################################################################//
/*!
 @file		QCPutViewController.h
 @brief		Put方法网络连接视图控制器
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/09/15     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import <UIKit/UIKit.h>

@interface QCPutViewController : UIViewController

@property (nonatomic, retain) IBOutlet UITextField *               urlText;
@property (nonatomic, retain) IBOutlet UIImageView *               imgPut;
@property (nonatomic, retain) IBOutlet UIButton *                  btnPut;
@property (nonatomic, retain) IBOutlet UILabel *                   status;

@end
