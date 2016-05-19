// ################################################################################//
//		文件名 : QCNavRootViewController.m
// ################################################################################//
/*!
 @file		QCNavRootViewController.m
 @brief		导航控制器的根视图控制器实现文件
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/11/17     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCNavRootViewController.h"
#import "QCNavFirstViewController.h"

@implementation QCNavRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //初始化导航栏内容
    [self initNavBar];
}

- (void)viewWillAppear:(BOOL)animated
{
    //根视图上不显示底部工具栏
    [self.navigationController setToolbarHidden:YES
                                       animated:YES];
    [super viewWillAppear:animated];
}

#pragma mark -
#pragma mark initial
- (void)initNavBar {
    self.title = @"根视图控制器";
}

#pragma mark -
#pragma mark Action
- (IBAction)actNext:(id)sender
{
    QCNavFirstViewController *aFirstVC = [[QCNavFirstViewController alloc] initWithNibName:@"QCNavFirstViewController"
                                                                                    bundle:nil];
    
    //将aFirstVC视图控制器压入栈
    [self.navigationController pushViewController:aFirstVC animated:YES];
    [aFirstVC release];
}

#pragma mark -
#pragma mark iOS6.0 prior
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

#pragma mark -
#pragma mark iOS6.0 later
- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotate{
    return YES;
}


@end
