// ################################################################################//
//		文件名 : QCPreviewViewController.h
// ################################################################################//
/*!
 @file		QCPreviewViewController.h
 @brief		大图视图控制器
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/10/24     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import <UIKit/UIKit.h>

@interface QCPreviewViewController : UIViewController

@property (nonatomic, retain) IBOutlet  UIImageView                 *previewImage;
@property (nonatomic, retain) IBOutlet  UIView                      *maskView;
@property (nonatomic, retain) IBOutlet  UIActivityIndicatorView     *indicator;
@property (nonatomic, retain) NSURL     *url;

@end
