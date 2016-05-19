// ################################################################################//
//		文件名 : QCRootViewController.m
// ################################################################################//
/*!
 @file		QCRootViewController.m
 @brief		作为程序根视图“导航控制器”的根视图类
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/09/12     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCRootViewController.h"
#import "QCPickerViewController.h"
#import "QCDatePickerViewController.h"
#import "QCCustomPickerViewController.h"

@implementation QCRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //导航栏的颜色设置
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:145.0f/255.0f
                                                                        green:190.0f/255.0f
                                                                         blue:5.0f/255.0f
                                                                        alpha:1.0f];
    
    //导航栏的标题
    self.title = @"取值控件示例";
}


#pragma mark -
#pragma mark Action
//界面上的三个按钮
//进入三种“取值控件”模式
- (IBAction)actSimplePickerView:(id)sender
{
    [self.navigationController pushViewController:[[[QCPickerViewController alloc] initWithNibName:@"QCPickerViewController"
                                                                                            bundle:nil]
                                                   autorelease]
                                         animated:YES];
}

- (IBAction)actDatePickerView:(id)sender
{
    [self.navigationController pushViewController:[[[QCDatePickerViewController alloc] initWithNibName:@"QCDatePickerViewController"
                                                                                          bundle:nil]
                                                   autorelease]
                                         animated:YES];
}

- (IBAction)actCustomizePickerView:(id)sender
{
    [self.navigationController pushViewController:[[[QCCustomPickerViewController alloc] initWithNibName:@"QCPickerViewController"
                                                                                              bundle:nil]
                                                   autorelease]
                                         animated:YES];
}

@end
