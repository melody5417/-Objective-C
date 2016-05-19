// ################################################################################//
//		文件名 : QCGetViewController.h
// ################################################################################//
/*!
 @file		QCGetViewController.h
 @brief		Get方法网络连接视图控制器
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/09/13     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import <UIKit/UIKit.h>

@interface QCGetViewController : UIViewController

@property (nonatomic, retain) IBOutlet UITextField *               urlText;
@property (nonatomic, retain) IBOutlet UIImageView *               imgGet;
@property (nonatomic, retain) IBOutlet UIButton *                  btnGet;
@property (nonatomic, retain) IBOutlet UILabel *                   status;
@property (nonatomic, retain) IBOutlet UISegmentedControl *         mode;

- (IBAction)getImage:(id)sender;

@end
