// ################################################################################//
//		文件名 : QCPersonInfoDataModel.h
// ################################################################################//
/*!
 @file		QCPersonInfoDataModel.h
 @brief		数据模型类头文件
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/11/12     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import <Foundation/Foundation.h>

@interface QCPersonInfoDataModel : NSObject

//姓名
@property(nonatomic, retain) NSString   *name;
//年龄
@property(nonatomic, assign) NSUInteger age;
//身高
@property(nonatomic, assign) NSUInteger height;
//婚否
@property(nonatomic, assign) BOOL       hasMarried;
//兴趣
@property(nonatomic, retain) NSArray    *hobbies;

@end
