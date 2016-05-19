// ################################################################################//
//		文件名 : QCThreeDAnimationViewController.h
// ################################################################################//
/*!
 @file		QCThreeDAnimationViewController.h
 @brief		3D翻页动画视图控制器
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/10/03     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import <UIKit/UIKit.h>

@interface QCThreeDAnimationViewController : UIViewController

@property (nonatomic, retain) IBOutlet UINavigationBar      *navBar;
@property (nonatomic, retain) IBOutlet UIBarButtonItem      *doneButton;
@property (nonatomic, retain) IBOutlet UIImageView          *bookCover;

- (IBAction)actClose:(id)sender;
- (IBAction)actAnimation:(id)sender;

@end
