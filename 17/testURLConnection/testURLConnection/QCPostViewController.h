// ################################################################################//
//		文件名 : QCPostViewController.h
// ################################################################################//
/*!
 @file		QCPostViewController.h
 @brief		Post方法网络连接视图控制器
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/09/15     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import <UIKit/UIKit.h>

@interface QCPostViewController : UIViewController

@property (nonatomic, retain) IBOutlet UITextField *               urlText;
@property (nonatomic, retain) IBOutlet UIImageView *               imgPost;
@property (nonatomic, retain) IBOutlet UIButton *                  btnPost;
@property (nonatomic, retain) IBOutlet UILabel *                   status;
@end
