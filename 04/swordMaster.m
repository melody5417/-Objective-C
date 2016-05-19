// ################################################################################//
//		文件名 : swordMaster.m
// ################################################################################//
/*!
 @file		swordMaster.m
 @brief		使莫邪剑者的类的头文件
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/08/18     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
//
#import "swordMaster.h"

@implementation swordMaster

- (void)takeSword
{
    //如果手中没拿莫邪，初始化之
    if (!_moXie) {
        _moXie = [[MoXieSword alloc] initWithProducerName:@"帅哥甲" 
                                          producerAbility:100];
        _moXie.delegate = self;
    }
}


- (void)wanJianGuiZong:(MoXieSword*)aSword
{
    
}

- (void)yiJinJing:(MoXieSword*)aSword
{
    
}

- (void)love
{
    
}

@end
