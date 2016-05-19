// ################################################################################//
//		文件名 : AppDelegate.m
// ################################################################################//
/*!
 @file		AppDelegate.m
 @brief		应用代理类实现文件
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2013/01/08     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "AppDelegate.h"
#import <sys/uio.h>
#import <asl.h>

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //跑完这句，可以通过Console.app查看效果
    [self printLogToSysConsole];
    
    //跑完这句，可以直接在Xcode的控制台查看效果
    [self printLogToXcode];
    
    return YES;
}

#pragma mark -
#pragma mark Utility
//往系统控制台中打印日志
- (void)printLogToSysConsole
{
    NSString    *strTest        = @"Hello System Console";
    aslclient   myASLClient     = asl_open(NULL, "com.apple.console", 0);
    
    asl_log(myASLClient,
            NULL,
            ASL_LEVEL_WARNING,
            "%s", [strTest UTF8String]);
    asl_close(myASLClient);
}

//使用stderr重定向日志到当前程序，即Xcode
- (void)printLogToXcode
{
    struct iovec v[10];
    
    char*   cTest01 = "Hello";
    char*   cTest02 = " ";
    char*   cTest03 = "Xcode";
    
    //Log内容
    v[0].iov_base = cTest01;
    v[0].iov_len  = strlen(cTest01);
    
    v[1].iov_base = cTest02;
    v[1].iov_len  = strlen(cTest02);
    
    v[2].iov_base = cTest03;
    v[2].iov_len  = strlen(cTest03);
    
    v[3].iov_base = "\n";
    v[3].iov_len  = 1;
    
    //调用stderr重定向到Xcode的控制台。
    writev(STDERR_FILENO, v, 4);
}

#pragma mark -
#pragma mark Template
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
