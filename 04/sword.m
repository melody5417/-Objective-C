// ################################################################################//
//		文件名 : sword.m
// ################################################################################//
/*!
 @file		sword.m
 @brief		武器剑类的实现文件
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/08/18     铁匠      文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
//
#import "sword.h"

@implementation sword

- (id)initWithName:(NSString*)aWeaponName
      producerName:(NSString*)aProducerName
   producerAbility:(int)abilityValue
{
    self = [super initWithName:aWeaponName
                  producerName:aProducerName
               producerAbility:abilityValue];
    if (self) 
    {
        if (aWeaponName) {
            _strName = [[NSString alloc] initWithString:aWeaponName];
        }
        else {
            _strName = DEFAULT_WEAPON_NAME;
        }
        
        
        //武器属性
        [self initSwordAttr];
    }
    
    return self;
}


- (void)initSwordAttr
{
    //对于剑属性的初始化
    _colorBody      = [[UIColor lightGrayColor] retain];
    _materialBody   = [[NSString alloc] initWithString:@"铁"];
    
    _colorSheath    = [[UIColor brownColor] retain];
    _materialSheath = [[NSString alloc] initWithString:@"皮革"];

    _colorHandle    = [[UIColor blackColor] retain];
    _materialHandle = [[NSString alloc] initWithString:@"木头"];
    
    _fLong          = 1.2f;
    _fWeight        = 20.0f;
}

- (int)attackValue
{
    switch (_quality) {
        case kNormalQuality:
            return 500;
        case kGoodQuality:
            return 700;
        case kExcellQuality:
            return 1100;
        default:
            return 20;
    }
}

@end
