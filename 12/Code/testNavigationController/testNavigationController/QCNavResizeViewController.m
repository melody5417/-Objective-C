// ################################################################################//
//		文件名 : QCNavResizeViewController.m
// ################################################################################//
/*!
 @file		QCNavResizeViewController.m
 @brief		超大尺寸视图控制器实现文件
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/11/17     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCNavResizeViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation QCNavResizeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //初始化导航栏内容
    [self initNavBar];
}

#pragma mark -
#pragma mark Initial
- (void)initNavBar
{
    self.navigationItem.title = @"动画和视图resize";
    self.navigationItem.prompt = @"我是额外信息";
    //左侧不用backBarButtonItem，使用自定义的左侧控件代替
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"你快回来！"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(actBack:)]
                                             autorelease];
}

#pragma mark -
#pragma mark Action
- (IBAction)actBack:(id)sender
{
    //反向的逆动画
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.5f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.removedOnCompletion = NO;
    animation.type = @"pageUnCurl";
    //不同的设置旋转方向，翻页动画效果有所区别
    switch ([[UIApplication sharedApplication] statusBarOrientation]) {
        case  UIInterfaceOrientationPortrait:
            animation.subtype = kCATransitionFromBottom;
            break;
        case  UIInterfaceOrientationPortraitUpsideDown:
            animation.subtype = kCATransitionFromLeft;
            break;
        case  UIInterfaceOrientationLandscapeLeft:
            animation.subtype = kCATransitionFromRight;
            break;
        case  UIInterfaceOrientationLandscapeRight:
            animation.subtype = kCATransitionFromLeft;
            break;
        default:
            animation.subtype = kCATransitionFromBottom;
            break;
    }
    animation.endProgress = 1.0f;
    [self.navigationController.view.layer addAnimation:animation forKey:@"animation"];
    
    [self.navigationController popViewControllerAnimated:NO];
}

@end
