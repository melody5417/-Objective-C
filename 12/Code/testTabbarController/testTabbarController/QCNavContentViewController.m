// ################################################################################//
//		文件名 : QCNavContentViewController.m
// ################################################################################//
/*!
 @file		QCNavContentViewController.m
 @brief		TabbarController的第三个视图控制器：“导航视图”
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/11/19     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCNavContentViewController.h"
#import "QCTestViewController.h"

@implementation QCNavContentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //Tabbar图标
        self.tabBarItem.image = [UIImage imageNamed:@"test"];
        
        //Tabbar标题
        self.title = @"导航栏";
    }
    return self;
}

#pragma mark -
#pragma mark Action
- (IBAction)actNext:(id)sender
{
    QCTestViewController *testVC = [[[QCTestViewController alloc] initWithNibName:@"QCTestViewController"
                                                                           bundle:nil
                                                                            title:@"隐藏Tabbar"] autorelease];
    //新视图不显示标签栏
    testVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:testVC
                                         animated:YES];
}

@end
