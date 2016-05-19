// ################################################################################//
//		文件名 : club.h
// ################################################################################//
/*!
 @file		club.h
 @brief		球队类头文件
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/09/01     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "footballer.h"

@interface club : NSObject

@property (nonatomic, retain) footballer        *captain;
@property (nonatomic, retain) NSMutableArray    *members;
//可尝试使用NSMutableSet
//@property (nonatomic, retain) NSMutableSet      *members;

@end
