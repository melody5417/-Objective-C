// ################################################################################//
//		文件名 : MoXieSword.m
// ################################################################################//
/*!
 @file		MoXieSword.m
 @brief		莫邪剑的类的实现文件
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/08/18     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "MoXieSword.h"
#import "NSObject+Enemy.h"

@implementation MoXieSword
@synthesize delegate = _delegate;

- (id)initWithProducerName:(NSString *)aProducerName 
           producerAbility:(int)abilityValue
{
    //调用初始化方法，默认设置成“莫邪”名字
    return [self initWithName:@"莫邪" 
                 producerName:aProducerName 
              producerAbility:abilityValue];
}

- (id)initWithName:(NSString*)aWeaponName
      producerName:(NSString*)aProducerName
   producerAbility:(int)abilityValue
{
    self = [super initWithName:aWeaponName
                  producerName:aProducerName
               producerAbility:abilityValue];
    if (self) 
    {
        //武器名字不是“莫邪”，我们就强制赋值“莫邪”
        if (![_strName isEqualToString:@"莫邪"]) {
            _strName = [[NSString alloc] initWithString:@"莫邪"];
        }
        
        //默认武器属性
        _fLong      = 1.2f;
        _fWeight    = 20.0f;
    }
    
    return self;
}

- (void)initSwordAttr
{
    _colorBody      = [[UIColor darkGrayColor] retain];
    _materialBody   = [[NSString alloc] initWithString:@"陨石"];
    
    //莫邪没有剑鞘
    _colorSheath    = nil;
    _materialSheath = nil;
    
    _colorHandle    = [[UIColor whiteColor] retain];
    _materialHandle = [[NSString alloc] initWithString:@"千年神木"];
    
    _fLong          = 1.5f;
    _fWeight        = 40.0f;
}

- (void)attack:(id)hitTarget
{
    //没有攻击对象
    if (!hitTarget) {
        return;
    }
    
//    //攻击对象判定
//    if (([(NSObject*)hitTarget respondsToSelector:@selector(receiveAttack:)])) {
//        //对象遭受10倍的莫邪攻击
//        [hitTarget performSelector:@selector(receiveAttack:)
//                        withObject:[NSNumber numberWithInt:([self attackValue] * 10)]];
//    }
    [(NSObject*)hitTarget receiveAttack:[self attackValue]];
}

- (void)love:(id)loveTarger
{
    if (!loveTarger) {
        return;
    }
    
    //告诉代理，你是时候要给别人爱了！
    if (_delegate) {
        [_delegate love];
    }
}

- (void)attackPower:(id)hitTarget
{
    if (!hitTarget) {
        return;
    }
    
    if (_delegate) {
        //万剑归宗
        [_delegate wanJianGuiZong:self];
        //易筋经
        [_delegate yiJinJing:self];
        
        //由于没有强制代理执行“太空步”
        //所以我们要对太空步进行判定，是不是有“太空步”的招式
        if ([(NSObject*)_delegate respondsToSelector:@selector(spaceStep:)]) {
            [_delegate spaceStep:self];
        }
    }
}

- (int)attackValue
{
    //莫邪必须神匠等级的人物制作，否则发挥不出莫邪的真正实力。
    switch (_quality) {
        case kExcellQuality:
            return 100000;
        default:
            return 700;
    }
}

@end
