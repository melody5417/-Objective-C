// ################################################################################//
//		文件名 : club.m
// ################################################################################//
/*!
 @file		club.m
 @brief		球队类实现文件
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/09/01     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "club.h"

@implementation club
@synthesize name;
@synthesize members;
@synthesize captain;

- (id)init
{
    self = [super init];
    if (self) {
        members     = [[NSMutableArray alloc] initWithCapacity:0];
        name        = [[NSString alloc] initWithString:@"未取名球队"];
        captain     = nil;
    }
    return self;
}

- (void)dealloc
{
    [name release];
    [captain release];
    [members release];
    [super dealloc];
}

//为绑定提供的接口
- (void)selectCaptain:(id)object
{
    if (object) {
        [self setCaptain:object];
    }
}

- (void)setCaptain:(footballer *)aNewCaptain
{
    //新旧队长交替
    if (captain != nil) {
        captain.isCaptain = NO;
    }
    if (aNewCaptain != nil) {
        aNewCaptain.isCaptain = YES;
    }
    
    [captain release];
    captain = [aNewCaptain retain];
}

#pragma mark -
#pragma mark KVC Protocol
- (NSUInteger)countOfMembers {
    return [members count];
}

- (id)objectInMembersAtIndex:(NSUInteger)idx {
    return [members objectAtIndex:idx];
}

- (void)getMembers:(id[])aBuffer range:(NSRange)aRange {
    return [members getObjects:aBuffer
                         range:aRange];
}

- (void)insertObject:(id)anObject 
    inMembersAtIndex:(NSUInteger)idx 
{
    [members insertObject:anObject
                  atIndex:idx];
}

- (void)removeObjectFromMembersAtIndex:(NSUInteger)idx {
    [members removeObjectAtIndex:idx];
}

- (void)replaceObjectInMembersAtIndex:(NSUInteger)index withObject:(id)object {
    [members replaceObjectAtIndex:index
                       withObject:object];
}

@end
