// ################################################################################//
//		文件名 : QCViewController.h
// ################################################################################//
/*!
 @file		QCViewController.h
 @brief		显示视图类
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/10/05     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import <UIKit/UIKit.h>

@interface QCViewController : UIViewController<UITextFieldDelegate>
{
    //保存当前编辑中的UITextField控件
    UITextField *_activeTextField;
    
    //键盘是否显示中
    BOOL         _keyboardShowing;
    
    //键盘大小
    CGSize       _sizeKeyboard;
    
    //是否旋转中
    BOOL         _rotating;
}
@property (nonatomic, retain) IBOutlet UIView       *whiteView;
@property (nonatomic, retain) IBOutlet UITextView   *textView;
@property (nonatomic, retain) IBOutlet UIView       *contentView;
@property (nonatomic, retain) IBOutlet UITextField  *txtUserName;
@property (nonatomic, retain) IBOutlet UITextField  *txtPassword;


@end
