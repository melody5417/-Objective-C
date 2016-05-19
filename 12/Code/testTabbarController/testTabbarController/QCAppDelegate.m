// ################################################################################//
//		文件名 : QCAppDelegate.m
// ################################################################################//
/*!
 @file		QCAppDelegate.m
 @brief		应用代理类实现文件
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/11/19     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCAppDelegate.h"
#import "QCBadgeViewController.h"
#import "QCSheetActionViewController.h"
#import "QCNavContentViewController.h"
#import "QCTestViewController.h"

@implementation QCAppDelegate {
    QCBadgeViewController *_badgeVC;
}

- (void)dealloc
{
    [_window release];
    [_tabBarController release];
    [_badgeVC release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];

    //添加统一的背景图
    [self addQCBackground];

    //获得Tabbar的内容数组
    NSArray *tabBarContents = [self tabbarContentArray];
    
    //
    //制作TabbarController
    self.tabBarController = [[[QCTabbarController alloc] init] autorelease];
    self.tabBarController.delegate = self;
    //所有需要供使用的视图控制器
    self.tabBarController.viewControllers = tabBarContents;
    //支持编辑的视图控制器数组
    self.tabBarController.customizableViewControllers = tabBarContents;
    self.tabBarController.moreNavigationController.navigationBar.barStyle = UIBarStyleBlack;
        
    self.window.rootViewController = self.tabBarController;
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

- (NSArray*)tabbarContentArray
{
    NSMutableArray      *arrViewControllers = [NSMutableArray arrayWithCapacity:0];
    
//1) Badge视图控制器
    QCBadgeViewController *aBadgeVC = [[QCBadgeViewController alloc] initWithNibName:@"QCBadgeViewController"
                                                                              bundle:nil];
    [arrViewControllers addObject:aBadgeVC];
    //成员量保存下来，为之后UITabbarController代理回调函数使用
    if (!_badgeVC) {
        _badgeVC = aBadgeVC;
    }
    
//2) Sheet视图控制器
    [arrViewControllers addObject:[[[QCSheetActionViewController alloc] initWithNibName:@"QCSheetActionViewController"
                                                                                 bundle:nil]
                                   autorelease]];
    
//3) 导航视图控制器
    UINavigationController  *nav = [[[UINavigationController alloc] initWithRootViewController:
                                     [[[QCNavContentViewController alloc] initWithNibName:@"QCNavContentViewController"
                                                                                 bundle:nil] autorelease]]
                                    autorelease];
    nav.navigationBar.barStyle = UIBarStyleBlack;
    [arrViewControllers addObject:nav];
    
//4) 随机内容颜色的视图控制器
    QCTestViewController *aTestVC = nil;
    //制作10个不同背景色的视图控制器
    for (int iLoop = 0; iLoop < 7; iLoop++) {
        aTestVC = [[[QCTestViewController alloc] initWithNibName:@"QCTestViewController"
                                                          bundle:nil
                                                           title:[NSString stringWithFormat:@"我是第%d个", (iLoop+4)]]
                   autorelease];
        [arrViewControllers addObject:aTestVC];
    }

    return arrViewControllers;
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

// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}

- (void)tabBarController:(UITabBarController *)tabBarController willBeginCustomizingViewControllers:(NSArray *)viewControllers
{
    int nIndexBadgeVC = [tabBarController.viewControllers indexOfObject:_badgeVC];
    
    [_badgeVC beginCustomizing:nIndexBadgeVC
            onTabBarController:tabBarController];
}

// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
    int nIndexBadgeVC = [tabBarController.viewControllers indexOfObject:_badgeVC];
    [_badgeVC endCustomizing:nIndexBadgeVC
          onTabBarController:tabBarController];
}

@end
