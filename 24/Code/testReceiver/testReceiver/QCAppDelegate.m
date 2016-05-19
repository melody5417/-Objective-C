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
    
    self.viewController = [[[QCViewController alloc] initWithNibName:@"QCViewController"
                                                              bundle:nil]
                           autorelease];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    [self.viewController printLog:
     [NSString stringWithFormat:@"\n>\n[application:didFinishLaunchingWithOptions:]\n%@", [launchOptions description]]];
    
    return YES;
}

- (void)addQCBackground
{
    UIImageView *QCBackground = [[UIImageView alloc] initWithFrame:self.window.bounds];
    //编译时区分最低兼容操作系统版本，为使用不同API
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_6_0
    QCBackground.image = [[UIImage imageNamed:@"background"] resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch];
#else
    QCBackground.image = [[UIImage imageNamed:@"background"] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
#endif
    [self.window addSubview:QCBackground];
    SAFE_RELEASE(QCBackground)
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
	[self.viewController printLog:
     [NSString stringWithFormat:@"\n>\n[application:openURL:sourceApplication:annotation:]\nURL:[%@]\nSourceApplication:[%@]\nAnnotation:[%@]", url, sourceApplication, annotation]];
	
	return YES;
	
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    [self.viewController printLog:
     [NSString stringWithFormat:@">[application:handleOpenURL:]\nURL:[%@]", url]];
	
	return YES;
}

@end
