// ################################################################################//
//		文件名 : weapon.m
// ################################################################################//
/*!
 @file		weapon.m
 @brief		武器类的实现文件
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/08/18     铁匠      文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
//
#import "weapon.h"
#import "NSObject+Enemy.h"

@implementation weapon

- (id)initWithName:(NSString*)aWeaponName
      producerName:(NSString*)aProducerName
   producerAbility:(int)abilityValue
{
    self = [super init];
    if (self) 
    {
        //武器名字赋值
        if (aWeaponName) {
            _strName = [[NSString alloc] initWithString:aWeaponName];
        }
        else {
            _strName = [DEFAULT_WEAPON_NAME retain];
        }
        
        //武器制作人赋值
        if (aProducerName) {
            _strProducer = [[NSString alloc] initWithString:aProducerName];
        }
        else {
            _strProducer = [DEFAULT_WEAPON_PRODUCER retain];
        }
        
        //当前时间
        _dateBirth = [[NSDate date] retain];
        
        //根据制作人的实力决定武器的品质
        if (abilityValue<=10) {
            _quality = kPoorQuality;
        }
        else if(abilityValue <=50) {
            _quality = kNormalQuality;
        }
        else if(abilityValue < 80) {
            _quality = kGoodQuality;
        }
        else {
            _quality = kExcellQuality;
        }
        
        //默认武器属性
        _fLong      = DEFAULT_WEAPON_LONG;
        _fWeight    = DEFAULT_WEAPON_WEIGHT;
    }
    
    return self;
}

- (void)dealloc
{
    [_strName release];
    [_strProducer release];
    [_dateBirth release];
    
    [super dealloc];
}

- (void)attack:(id)hitTarget
{
    //没有攻击对象
    if (!hitTarget) {
        return;
    }

    //敌人遭受攻击
//    if (([(NSObject*)hitTarget respondsToSelector:@selector(receiveAttack:)])) {
//        //对象遭受攻击
//        [hitTarget performSelector:@selector(receiveAttack:)
//                        withObject:[NSNumber numberWithInt:[self attackValue]]];
//    }
    [(NSObject*)hitTarget receiveAttack:[self attackValue]];

}

- (int)attackValue
{
    //根据品质决定攻击力
    switch (_quality) {
        case kNormalQuality:
            return 50;
        case kGoodQuality:
            return 70;
        case kExcellQuality:
            return 110;
        default:
            return 20;
    }
}

@end
