// ################################################################################//
//		文件名 : QCNavMultiControlsViewController.m
// ################################################################################//
/*!
 @file		QCNavMultiControlsViewController.m
 @brief		多控件视图控制器实现文件
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/11/17     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCNavMultiControlsViewController.h"

@implementation QCNavMultiControlsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //初始化导航栏内容
    [self initNavBar];
}

- (void)viewWillAppear:(BOOL)animated
{
    //此视图上不显示底部工具栏
    [self.navigationController setToolbarHidden:YES
                                       animated:YES];
    [super viewWillAppear:animated];
}

#pragma mark -
#pragma mark initial
- (void)initNavBar
{
    //
    //导航栏中间控件
    UILabel *labTitle = [[[UILabel alloc] initWithFrame:CGRectMake(0.0f,
                                                                   0.0f,
                                                                   1000.0f,
                                                                   32.0f)] autorelease];
    labTitle.backgroundColor    = [UIColor darkGrayColor];
    labTitle.textColor          = [UIColor whiteColor];
    labTitle.text               = @"看右侧！";
    labTitle.textAlignment      = NSTextAlignmentCenter;
    
    //配置一个UILabel到导航栏中间
    self.navigationItem.titleView = labTitle;
    
    //
    //导航栏右边的多控件
    //承载多控件的背景透明视图
    UIView  *aView = [[[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                               0.0f,
                                                               60.0f,
                                                               32.0f)]
                      autorelease];
    aView.backgroundColor = [UIColor clearColor];
    
    
    //第一个按钮
    UIButton *buttonA = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [buttonA setTitle:@"按钮" forState:UIControlStateNormal];
    buttonA.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    buttonA.frame = CGRectMake(0.0f,
                               CGRectGetHeight(aView.frame)/2 - 13.0f,
                               30.0f,
                               26.0f);
    [buttonA addTarget:self
                action:@selector(actButtonA:)
      forControlEvents:UIControlEventTouchUpInside];
    [aView addSubview:buttonA];
    
    //第二个按钮
    UIButton *buttonB = [UIButton buttonWithType:UIButtonTypeInfoLight];
    buttonB.frame = CGRectMake(CGRectGetWidth(aView.frame) - CGRectGetWidth(buttonB.frame),
                               CGRectGetHeight(aView.frame)/2 - CGRectGetHeight(buttonB.frame)/2,
                               CGRectGetWidth(buttonB.frame),
                               CGRectGetHeight(buttonB.frame));
    [buttonB addTarget:self
                action:@selector(actButtonB:)
      forControlEvents:UIControlEventTouchUpInside];
    [aView addSubview:buttonB];
    
    //用一个UIView对象包住两个按钮，设置到导航栏的右侧控件
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:aView] autorelease];
}

#pragma mark -
#pragma mark Action
- (IBAction)actButtonA:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"我是类<%@>", NSStringFromClass([self class])]
                                                    message:[NSString stringWithFormat:@"继续在<%@>方法中撰写按钮功能", NSStringFromSelector(_cmd)]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}

- (IBAction)actButtonB:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"我是类<%@>", NSStringFromClass([self class])]
                                                    message:[NSString stringWithFormat:@"继续在<%@>方法中撰写按钮功能", NSStringFromSelector(_cmd)]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}

@end
