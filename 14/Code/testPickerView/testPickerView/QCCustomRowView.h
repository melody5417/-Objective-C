// ################################################################################//
//		文件名 : QCCustomRowView.h
// ################################################################################//
/*!
 @file		QCCustomRowView.h
 @brief		自定义取值控件的行内容
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/09/12     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import <UIKit/UIKit.h>

#define CUSTOM_HEIGHT   60.0f
#define CUSTOM_WIDTH    240.0f

@interface QCCustomRowView : UIView
{
@private
    //自定义行的头像
    UIImageView *_photoView;
    //自定义行的球员名
    UILabel     *_nameLabel;
}

@property(nonatomic, retain) UIImage          *photo;
@property(nonatomic, retain) NSString         *name;

@end
