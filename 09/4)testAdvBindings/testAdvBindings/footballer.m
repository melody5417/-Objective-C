// ################################################################################//
//		文件名 : footballer.m
// ################################################################################//
/*!
 @file		footballer.m
 @brief		球员类实现文件
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/09/01     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "footballer.h"

@implementation footballer
@synthesize name;
@synthesize no;
@synthesize isCaptain;

- (id)init
{
    self = [super init];
    if (self) {
        name        = [[NSString alloc] initWithString:@"未知球员"];
        no          = 0;
        isCaptain   = NO;
    }
    return self;
}

- (void)dealloc
{
    [name release];
    [super dealloc];
}

//KVC中，对于key的特殊处理
- (id)valueForUndefinedKey:(NSString *)key
{
    if (key && [key isEqualToString:@"no"]) {
        return [NSNumber numberWithInt:0];
    }
    
    return [super valueForUndefinedKey:key];
}

//KVC中，对于赋值时赋nil的特殊处理
- (void)setNilValueForKey:(NSString *)theKey {
    if ([theKey isEqualToString:@"name"]) {
        [self setValue:@"unknownName" forKey:@"name"];
    }
    else if ([theKey isEqualToString:@"no"]) {
        [self setValue:[NSNumber numberWithInt:0] forKey:@"no"];
    }
    else {
        [super setNilValueForKey:theKey];
    }
}

@end
