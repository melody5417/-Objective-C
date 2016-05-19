// ################################################################################//
//		文件名 : NSObject+Enemy.m
// ################################################################################//
/*!
 @file		NSObject+Enemy.m
 @brief		NSObject的Enemy扩展
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/08/18     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*

#import "NSObject+Enemy.h"

@implementation NSObject (Enemy)

- (void)receiveAttack:(int)attackValue
{
    if (attackValue > 100) {
        NSLog(@"Attack effect, I'm dead!");
    }
    else {
        NSLog(@"Defend successfully, haha!");
    }
}

@end
