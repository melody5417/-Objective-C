// ################################################################################//
//		文件名 : AppDelegate.m
// ################################################################################//
/*!
 @file		AppDelegate.m
 @brief		应用代理类实现文件
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/09/03     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "AppDelegate.h"

NSString* const DefaultTitle = @"万万科楼盘";
NSInteger const DefaultPrice = 20000;

@implementation AppDelegate
@synthesize titleHouse; 
@synthesize housePrice;
@synthesize window = _window;

- (void)dealloc {
    self.titleHouse = nil;
    [super dealloc]; 
}

- (BOOL)windowShouldClose:(id)sender
{
    [NSApp terminate:self];
    return YES;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    //初始化界面
    [self reset:nil];
}

- (IBAction) reset:(id)sender { 
    self.titleHouse = DefaultTitle; 
    self.housePrice = DefaultPrice;
}

@end
