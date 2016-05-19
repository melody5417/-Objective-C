// ################################################################################//
//		文件名 : QCAppDelegate.h
// ################################################################################//
/*!
 @file		QCAppDelegate.h
 @brief		应用代理类实现文件
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/09/13     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import <UIKit/UIKit.h>

@interface QCAppDelegate : UIResponder <UIApplicationDelegate> {
    NSInteger               _networkingCount;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *rootViewController;

+ (QCAppDelegate *)sharedAppDelegate;
- (NSURL *)smartURLForString:(NSString *)str;

- (void)didStartNetworking;
- (void)didStopNetworking;
@end
