// ################################################################################//
//		文件名 : QCBounceAnimationViewController.h
// ################################################################################//
/*!
 @file		QCBounceAnimationViewController.h
 @brief		弹跳动画视图控制器
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/10/03     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import <UIKit/UIKit.h>

@interface QCBounceAnimationViewController : UIViewController

@property (nonatomic, retain) IBOutlet UIButton             *btnLogo;
@property (nonatomic, retain) IBOutlet UINavigationBar      *navBar;
@property (nonatomic, retain) IBOutlet UISegmentedControl   *segmentControl;
@property (nonatomic, retain) IBOutlet UIBarButtonItem      *doneButton;
@property (nonatomic, retain) IBOutlet UIImageView          *imgLighting;


- (IBAction)actClose:(id)sender;
- (IBAction)actAnimation:(id)sender;

@end
