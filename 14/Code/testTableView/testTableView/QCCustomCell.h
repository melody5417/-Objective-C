// ################################################################################//
//		文件名 : QCCustomCell.h
// ################################################################################//
/*!
 @file		QCCustomCell.h
 @brief		自定义式样表视图的行
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/12/05     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import <UIKit/UIKit.h>

@interface QCCustomCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UIImageView *playerPhoto;
@property (retain, nonatomic) IBOutlet UILabel *playerName;
@property (retain, nonatomic) IBOutlet UILabel *playerRole;
@property (retain, nonatomic) IBOutlet UILabel *playerNumber;
@end
