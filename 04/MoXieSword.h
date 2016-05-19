// ################################################################################//
//		文件名 : MoXieSword.h
// ################################################################################//
/*!
 @file		MoXieSword.h
 @brief		莫邪剑的类的头文件
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/08/18     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "sword.h"

@protocol MoXieUser;
@interface MoXieSword : sword
{
    //代理对象的变量
    id<MoXieUser>   _delegate;
}

@property (nonatomic, assign) id<MoXieUser>   delegate;


- (id)initWithProducerName:(NSString *)aProducerName 
           producerAbility:(int)abilityValue;

- (void)attackPower:(id)hitTarget;
- (void)love:(id)loveTarger;
@end

//代理对象需要满足的协议
@protocol MoXieUser <NSObject>

//强制实现
@required
- (void)wanJianGuiZong:(MoXieSword*)aSword;
- (void)yiJinJing:(MoXieSword*)aSword;

- (void)love;

//非强制实现
@optional
- (void)spaceStep:(MoXieSword*)aSword;


@end