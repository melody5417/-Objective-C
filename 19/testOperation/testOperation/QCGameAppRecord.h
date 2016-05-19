// ################################################################################//
//		文件名 : QCGameAppRecord.h
// ################################################################################//
/*!
 @file		QCGameAppRecord.h
 @brief		表视图中的游戏数据模型
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/10/24     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import <Foundation/Foundation.h>

@interface QCGameAppRecord : NSObject
@property (nonatomic, retain) NSString  *name;
@property (nonatomic, retain) NSString  *price;
@property (nonatomic, retain) NSString  *thumbImageURLString;
@property (nonatomic, retain) NSString  *largeImageURLString;
@property (nonatomic, retain) UIImage   *imgThumb;
@end
