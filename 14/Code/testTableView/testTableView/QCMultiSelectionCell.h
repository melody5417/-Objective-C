// ################################################################################//
//		文件名 :QCMultiSelectionCell.h
// ################################################################################//
/*!
 @file		QCMultiSelectionCell.h
 @brief		多选功能表视图控制器的自定义行
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/12/06     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import <UIKit/UIKit.h>
@interface QCMultiSelectionCell : UITableViewCell
{
@private
    //是否选中状态的图标
    UIImageView *_imgSelectionMark;
    //是否选中状态的变量
    BOOL        _isSelected;
}
@property(nonatomic, assign) BOOL   checked;

- (void)setChecked:(BOOL)checked;

@end
