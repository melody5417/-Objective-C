// ################################################################################//
//		文件名 : sword.h
// ################################################################################//
/*!
 @file		sword.h
 @brief		武器剑类的头文件
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/08/18     铁匠      文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
//
#import "weapon.h"

@interface sword : weapon{
    
    UIColor     *_colorBody;        //剑身颜色
    NSString    *_materialBody;     //剑身材质
    
    UIColor     *_colorSheath;      //剑鞘颜色
    NSString    *_materialSheath;   //剑鞘材质
    
    UIColor     *_colorHandle;      //剑柄颜色
    NSString    *_materialHandle;   //剑柄材质
}

- (void)initSwordAttr;

@end
