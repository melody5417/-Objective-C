// ################################################################################//
//		文件名 : AppDelegate.h
// ################################################################################//
/*!
 @file		AppDelegate.h
 @brief		应用代理类头文件
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/09/03     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign)  IBOutlet    NSWindow    *window;
@property (retain)  NSString                *titleHouse; 
@property (assign)  int                     housePrice;

- (IBAction) reset:(id)sender;

@end
