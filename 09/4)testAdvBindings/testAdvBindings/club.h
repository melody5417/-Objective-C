// ################################################################################//
//		文件名 : club.h
// ################################################################################//
/*!
 @file		club.h
 @brief		球队类头文件
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/09/01     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "footballer.h"

@interface club : NSObject

@property (nonatomic, retain) NSString          *name;
@property (nonatomic, retain) footballer        *captain;
@property (nonatomic, retain) NSMutableArray    *members;

//对于容器键的KVC协议实现
- (NSUInteger)countOfMembers;
- (id)objectInMembersAtIndex:(NSUInteger)idx;
- (void)getMembers:(id[])aBuffer range:(NSRange)aRange;

- (void)insertObject:(id)anObject 
    inMembersAtIndex:(NSUInteger)idx;

- (void)removeObjectFromMembersAtIndex:(NSUInteger)idx;
- (void)replaceObjectInMembersAtIndex:(NSUInteger)index withObject:(id)object;

//为绑定提供的接口
- (void)selectCaptain:(id)object;

@end
