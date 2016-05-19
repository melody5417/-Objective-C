// ################################################################################//
//		文件名 : QCPersonInfoDataModel.m
// ################################################################################//
/*!
 @file		QCPersonInfoDataModel.m
 @brief		数据模型类实现文件
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/11/12     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCPersonInfoDataModel.h"

@implementation QCPersonInfoDataModel
//使用@synthesize语法使得编译器自动生成@property变量的Getter和Setter方法
@synthesize name = _name;
@synthesize age;
@synthesize height;
@synthesize hasMarried;
@synthesize hobbies = _hobbies;

- (void)dealloc
{
    [_name release];
    [_hobbies release];
    
    [super dealloc];
}

@end
