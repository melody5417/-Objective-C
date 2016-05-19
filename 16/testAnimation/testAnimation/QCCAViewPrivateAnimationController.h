// ################################################################################//
//		文件名 : QCCAViewPrivateAnimationController.h
// ################################################################################//
/*!
 @file		QCCAViewPrivateAnimationController.h
 @brief		CA私有动画视图控制器
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/10/03     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import <UIKit/UIKit.h>

@interface QCCAViewPrivateAnimationController : UIViewController<UIActionSheetDelegate>

@property (nonatomic, retain) IBOutlet UIView               *animationView;
@property (nonatomic, retain) IBOutlet UIImageView          *imgBG1;
@property (nonatomic, retain) IBOutlet UIImageView          *imgBG2;
@property (nonatomic, retain) IBOutlet UIButton             *btnSelectAnimation;
@property (nonatomic, retain) IBOutlet UINavigationBar      *navBar;
@property (nonatomic, retain) IBOutlet UIBarButtonItem      *doneButton;

- (IBAction)actClose:(id)sender;
- (IBAction)actAnimation:(id)sender;
- (IBAction)actChooseAnimation:(id)sender;
@end
