// ################################################################################//
//		文件名 : NSObject+Enemy.h
// ################################################################################//
/*!
 @file		NSObject+Enemy.h
 @brief		NSObject的Enemy扩展
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/08/18     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import <Foundation/Foundation.h>

@interface NSObject (Enemy)
//收到攻击的处理接口
- (void)receiveAttack:(int)attackValue;

@end
