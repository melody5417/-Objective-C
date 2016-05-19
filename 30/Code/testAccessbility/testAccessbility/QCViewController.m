// ################################################################################//
//		文件名 : QCViewController.m
// ################################################################################//
/*!
 @file		QCViewController.m
 @brief		显示视图类
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/12/10     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCViewController.h"
#import "QCXIBAccessbilityViewController.h"
#import "QCCustomAccessbilityViewController.h"

@implementation QCViewController

- (void)viewDidLoad
{
    //导航栏的颜色设置
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:145.0f/255.0f
                                                                        green:190.0f/255.0f
                                                                         blue:5.0f/255.0f
                                                                        alpha:1.0f];
    //导航栏的标题
    self.title = @"辅助功能示例";
    
    [super viewDidLoad];
}

- (IBAction)actXibAccessibility:(id)sender
{
    [self.navigationController pushViewController:
     [[[QCXIBAccessbilityViewController alloc] initWithNibName:@"QCXIBAccessbilityViewController"
                                                        bundle:nil]
      autorelease]
                                         animated:YES];
}
- (IBAction)actCustomizeAccessibility:(id)sender
{
    [self.navigationController pushViewController:
     [[[QCCustomAccessbilityViewController alloc] initWithNibName:@"QCCustomAccessbilityViewController"
                                                           bundle:nil]
      autorelease]
                                         animated:YES];
}

@end
