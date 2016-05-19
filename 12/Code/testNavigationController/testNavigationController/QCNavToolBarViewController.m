// ################################################################################//
//		文件名 : QCNavToolBarViewController.m
// ################################################################################//
/*!
 @file		QCNavToolBarViewController.m
 @brief		工具栏视图控制器实现文件
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/11/17     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCNavToolBarViewController.h"

@implementation QCNavToolBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //初始化导航栏内容
    [self initNavBar];
    
    //单击手势的事件注册
    UITapGestureRecognizer  *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(actTap:)];
    [self.view addGestureRecognizer:tapGesture];
    [tapGesture release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    //更新工具栏
    [self updateToolBar];
    
    //将导航栏式样配置成全屏模式
    [self updateNavBarStyle:YES];
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    //将导航栏式样配置成默认模式
    [self updateNavBarStyle:NO];
    
    [super viewWillDisappear:animated];
}
#pragma mark -
#pragma mark initial
- (void)initNavBar {
    self.navigationItem.title = @"更改工具栏内容";
}

- (void)updateNavBarStyle:(BOOL)bAppear
{
    //全屏模式
    if (bAppear) {
        self.navigationController.navigationBar.translucent = YES;
        self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    }
    //默认模式
    else{
        self.navigationController.navigationBar.translucent = NO;
        self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    }
}

- (void)updateToolBar
{
    //工具栏的元素
    if (!_toolBarItems) {
        _toolBarItems = [[NSArray alloc] initWithObjects:
                         [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                                                                        target:self
                                                                        action:@selector(actStop:)] autorelease],
                         [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                        target:self
                                                                        action:NULL] autorelease],
                         [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera
                                                                        target:self
                                                                        action:@selector(actCamera:)] autorelease],
                         nil];
    }
    
    //修改工具栏的式样
    self.navigationController.toolbar.barStyle = UIBarStyleBlackOpaque;
    [self.navigationController setToolbarHidden:NO
                                       animated:YES];
    
    //为工具栏赋上新的元素
    if (self.toolbarItems != _toolBarItems) {
        self.toolbarItems = _toolBarItems;
    }
}

#pragma mark -
#pragma mark Action
- (IBAction)actStop:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"我是类<%@>", NSStringFromClass([self class])]
                                                    message:[NSString stringWithFormat:@"继续在<%@>方法中撰写按钮功能", NSStringFromSelector(_cmd)]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}

- (IBAction)actCamera:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"我是类<%@>", NSStringFromClass([self class])]
                                                    message:[NSString stringWithFormat:@"继续在<%@>方法中撰写按钮功能", NSStringFromSelector(_cmd)]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}

- (IBAction)actTap:(id)sender
{
    //全屏中
    if (self.navigationController.navigationBarHidden) {
        //状态栏显示
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
        //导航栏显示
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        //工具栏显示
        [self.navigationController setToolbarHidden:NO animated:YES];
    }
    //非全屏中
    else {
        //状态栏隐藏
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
        //导航栏隐藏
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        //工具栏隐藏
        [self.navigationController setToolbarHidden:YES animated:YES];
    }
}

@end
