// ################################################################################//
//		文件名 : QCCustomCell.m
// ################################################################################//
/*!
 @file		QCCustomCell.m
 @brief		自定义式样表视图的行
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/12/05     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCCustomCell.h"

@implementation QCCustomCell

- (void)dealloc {
    [_playerPhoto release];
    [_playerName release];
    [_playerRole release];
    [_playerNumber release];
    [super dealloc];
}

@end
