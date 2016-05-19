// ################################################################################//
//		文件名 : QCGameAppRecord.m
// ################################################################################//
/*!
 @file		QCGameAppRecord.m
 @brief		表视图中的游戏数据模型
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/10/24     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCGameAppRecord.h"

@implementation QCGameAppRecord
@synthesize name = _name;
@synthesize price = _price;
@synthesize thumbImageURLString = _thumbImageURLString;
@synthesize largeImageURLString = _largeImageURLString;
@synthesize imgThumb = _imgThumb;

- (void)dealloc
{
    SAFE_RELEASE(_name);
    SAFE_RELEASE(_price);
    SAFE_RELEASE(_thumbImageURLString);
    SAFE_RELEASE(_largeImageURLString);
    SAFE_RELEASE(_imgThumb);
    
    [super dealloc];
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"\nAppRecord:[%@]\n[%@]\n[%@]\n[%@]",
            (_name)?_name:@"",
            (_price)?_price:@"",
            (_thumbImageURLString)?_thumbImageURLString:@"",
            (_largeImageURLString)?_largeImageURLString:@""];
}

@end
