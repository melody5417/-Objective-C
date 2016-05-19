// ################################################################################//
//		文件名 : swordMaster.h
// ################################################################################//
/*!
 @file		swordMaster.h
 @brief		使莫邪剑者的类的头文件
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/08/18     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import <Foundation/Foundation.h>
#import "MoXieSword.h"

@interface swordMaster : NSObject<MoXieUser>
{
    //莫邪剑
    MoXieSword *_moXie;
}
@end
