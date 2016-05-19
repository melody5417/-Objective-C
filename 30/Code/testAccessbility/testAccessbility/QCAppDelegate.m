// ################################################################################//
//		文件名 : QCAppDelegate.m
// ################################################################################//
/*!
 @file		QCAppDelegate.m
 @brief		应用代理类实现文件
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/12/10     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCAppDelegate.h"
#import "QCViewController.h"

@implementation QCAppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    //添加统一的背景图
    [self addQCBackground];
    
    // Override point for customization after application launch.
    self.viewController = [[[QCViewController alloc] initWithNibName:@"QCViewController"
                                                              bundle:nil]
                           autorelease];
    self.window.rootViewController = [[[UINavigationController alloc] initWithRootViewController:self.viewController] autorelease];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)addQCBackground
{
    UIImageView *QCBackground = [[UIImageView alloc] initWithFrame:self.window.bounds];
    //编译时区分最低兼容操作系统版本，为使用不同API
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 60000
    QCBackground.image = [[UIImage imageNamed:@"background"] resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch];
#else
    QCBackground.image = [[UIImage imageNamed:@"background"] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
#endif
    [self.window addSubview:QCBackground];
    SAFE_RELEASE(QCBackground)
}

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
