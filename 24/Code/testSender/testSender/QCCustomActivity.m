// ################################################################################//
//		文件名 : QCCustomActivity.m
// ################################################################################//
/*!
 @file		QCCustomActivity.m
 @brief		自定义Activity按钮
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/12/11     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCCustomActivity.h"

@implementation QCCustomActivity
@synthesize delegate;

#pragma mark -
#pragma mark Override
- (NSString *)activityType {
    return @"MyActivityType";
}

- (NSString *)activityTitle {
    return @"MyActivity";
}

- (UIImage *)activityImage {
    return [UIImage imageNamed:@"openInIcon"];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems{
	return YES;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems;{
	NSLog(@"准备工作");
	
	[super prepareWithActivityItems:activityItems];
}

#pragma mark -
#pragma mark Other Override
- (void)performActivity{
	NSLog(@"执行");
    
    //...
    
    NSLog(@"完毕");
    if (self.delegate) {
        [self.delegate finishTask:self];
    }
}

@end
