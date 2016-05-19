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

@implementation AppDelegate

@synthesize window = _window;

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
}

- (BOOL)windowShouldClose:(id)sender
{
    [NSApp terminate:self];
    return YES;
}

@end
