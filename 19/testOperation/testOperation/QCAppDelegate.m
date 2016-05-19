// ################################################################################//
//		文件名 : QCAppDelegate.m
// ################################################################################//
/*!
 @file		QCAppDelegate.m
 @brief		应用代理类实现文件
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/10/23     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCAppDelegate.h"
#import "QCViewController.h"
#import "QCParserOperation.h"

//从以下链接中获得RSS的具体链接：
//http://phobos.apple.com/WebObjects/MZStoreServices.woa/ws/RSS?cc=CN
#define TOPGROSS_GAME_LINK  @"https://itunes.apple.com/cn/rss/topgrossingapplications/limit=50/genre=6014/xml"

@implementation QCAppDelegate
@synthesize queue = _queue;

- (void)dealloc {
    [_window release];
    [_viewController release];
    [_queue release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.viewController = [[[QCViewController alloc] initWithNibName:@"QCViewController"
                                                              bundle:nil]
                           autorelease];
    
    UINavigationController  *navController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
    }
    QCParserOperation *aOperation = [[QCParserOperation alloc] initWithURL:[NSURL URLWithString:TOPGROSS_GAME_LINK]
                                                     completionHandler:^(NSArray *arrResult){
                                                         dispatch_async(dispatch_get_main_queue(), ^{
                                                             if (self.viewController && arrResult && arrResult.count > 0) {
                                                                 self.viewController.dataSource = arrResult;
                                                                 [self.viewController reloadData];
                                                             }
                                                         });
                                                     }
                                                             errHander:^(NSError *error){
                                                                 dispatch_async(dispatch_get_main_queue(), ^{

                                                                     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"解析RSS文件失败"
                                                                                                                         message:[error localizedDescription]
                                                                                                                        delegate:nil
                                                                                                               cancelButtonTitle:@"好的"
                                                                                                               otherButtonTitles:nil];
                                                                     [alertView show];
                                                                     [alertView release];
                                                                     
                                                                 });
                                                             }
                                   ];
    [_queue addOperation:aOperation];
    SAFE_RELEASE(aOperation);
    
    return YES;
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
