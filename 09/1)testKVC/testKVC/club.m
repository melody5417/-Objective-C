// ################################################################################//
//		文件名 : club.m
// ################################################################################//
/*!
 @file		club.m
 @brief		球队类头文件
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/09/01     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "club.h"

@implementation club
@synthesize members;
@synthesize captain;

- (id)init
{
    self = [super init];
    if (self) {
        members = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (void)dealloc
{
    [captain release];
    [members release];
    [super dealloc];
}

//必须
//- (NSUInteger)countOfMembers {
//    return [members count];
//}

//下面两个方法需要实现一个
- (id)objectInMembersAtIndex:(NSUInteger)idx {
    return [members objectAtIndex:idx];
}

- (NSArray *)objectsAtIndexes:(NSIndexSet *)indexes{
    return [members objectsAtIndexes:indexes];
}

//不必须实现
- (void)getMembers:(id[])aBuffer range:(NSRange)aRange {
    return [members getObjects:aBuffer
                         range:aRange];
}

//下列两个方法
//必须实现其一
//提供新增功能
- (void)insertObject:(id)anObject 
    inMembersAtIndex:(NSUInteger)idx 
{
    [members insertObject:anObject
                  atIndex:idx];
}

- (void)insertMembers:(NSArray *)array atIndexes:(NSIndexSet *)indexes
{
    [members insertObjects:array
                 atIndexes:indexes];
}

//下列两个方法
//必须实现其一
//提供删除功能
- (void)removeObjectFromMembersAtIndex:(NSUInteger)idx {
    [members removeObjectAtIndex:idx];
}

- (void)removeMembersAtIndexes:(NSIndexSet *)indexes{
    [members removeObjectsAtIndexes:indexes];
}

//下列两个方法
//不必须实现
- (void)replaceObjectInMembersAtIndex:(NSUInteger)index withObject:(id)object {
    [members replaceObjectAtIndex:index
                       withObject:object];
}

- (void)replaceMembersAtIndexes:(NSIndexSet *)indexes withMembers:(NSArray *)array{
    [members replaceObjectsAtIndexes:indexes
                         withObjects:array];
}

////set
////必须实现
//- (NSUInteger)countOfMembers {
//    return [members count];
//}
//
////必须实现
//- (NSEnumerator*)enumeratorOfMembers{
//    return [members objectEnumerator];
//}
//
////必须实现
//- (footballer*)memberOfMembers:(footballer *)anPlayer{
//    return [members member:anPlayer];
//}
//
////下列两个方法
////必须实现其一
////提供新增功能
//- (void)addMembersObject:(footballer *)anObject {
//    [members addObject:anObject];
//}
//
//- (void)addMembers:(NSSet *)manyObjects {
//    [members unionSet:manyObjects];
//}
//
////下列两个方法
////必须实现其一
////提供删除功能
//- (void)removeMembersObject:(footballer *)anObject {
//    [members removeObject:anObject];
//}
//
//- (void)removeMembers:(NSSet *)manyObjects {
//    [members minusSet:manyObjects];
//}
//
////不必须实现
////提供整理求和功能
//- (void)intersectMembers:(NSSet *)otherObjects {
//    return [members intersectSet:otherObjects];
//}

@end
