// ################################################################################//
//		文件名 : QCDetailedViewController.h
// ################################################################################//
/*!
 @file		QCDetailedViewController.h
 @brief		球员的详细信息视图控制器
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/12/17     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import <UIKit/UIKit.h>
#import "QCDBManager.h"

@protocol DetailedViewControllerDelegate;
@interface QCDetailedViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property(nonatomic, assign)   id<DetailedViewControllerDelegate>   delegate;
@property(nonatomic, retain)   IBOutlet UIButton                    *photoButton;
@property(nonatomic, retain)   IBOutlet UITextField                 *nameTextField;
//创建时需要表视图提供球员信息，之后可以在代理回调函数中供表视图取得已更新的球员信息
@property(nonatomic, retain)   Player                               *playerInfo; 
@end

@protocol DetailedViewControllerDelegate <NSObject>
- (void)saveDetailedInfo:(QCDetailedViewController*)detailedInfoVC;
- (void)cancelDetailedInfo:(QCDetailedViewController*)detailedInfoVC;
@end
