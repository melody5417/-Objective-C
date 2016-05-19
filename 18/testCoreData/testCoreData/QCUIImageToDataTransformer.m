// ################################################################################//
//		文件名 : QCUIImageToDataTransformer.m
// ################################################################################//
/*!
 @file		QCUIImageToDataTransformer.m
 @brief		UIImage到Data的转换类，供CoreData使用
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/12/17     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCUIImageToDataTransformer.h"

@implementation QCUIImageToDataTransformer

+ (BOOL)allowsReverseTransformation {
    //正反方向的转换都支持
	return YES;
}

+ (Class)transformedValueClass {
    //输出是NSData格式
	return [NSData class];
}

- (id)transformedValue:(id)value {
    //属性->持久层数据库
    //从UIImage格式转换成NSData格式
	return UIImagePNGRepresentation(value);
}

- (id)reverseTransformedValue:(id)value {
    //持久层数据库->属性
    //从NSData格式转换成UIImage格式
	return [[[UIImage alloc] initWithData:value] autorelease];
}

@end
