// ################################################################################//
//		文件名 : QCThreeDAnimationViewController.m
// ################################################################################//
/*!
 @file		QCThreeDAnimationViewController.m
 @brief		3D翻页动画视图控制器
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/10/03     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCThreeDAnimationViewController.h"
#import <QuartzCore/QuartzCore.h>

#define degreesToRadians(x) (M_PI * (x) / 180.0)

@implementation QCThreeDAnimationViewController
@synthesize navBar = _navBar;
@synthesize doneButton;
@synthesize bookCover = _bookCover;

- (void)viewDidUnload
{
    [super viewDidUnload];

    self.navBar = nil;
    self.doneButton = nil;
    self.bookCover = nil;
}

#pragma mark -
#pragma mark Action
- (IBAction)actClose:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actAnimation:(id)sender
{
    self.navBar.topItem.rightBarButtonItem.enabled = NO;
    [self curlBookCover];
}

#pragma mark -
#pragma mark 3D CAAnimation
- (void)curlBookCover
{
    CABasicAnimation *curlAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
	curlAnimation.delegate          = self;
    curlAnimation.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    curlAnimation.fromValue         = [NSNumber numberWithFloat:0.0f];
    curlAnimation.toValue           = [NSNumber numberWithFloat:degreesToRadians(-180)];
    curlAnimation.fillMode                  = kCAFillModeForwards;
    curlAnimation.removedOnCompletion       = NO;
    curlAnimation.duration                  = 2.0f;
    //绕左边沿
    _bookCover.layer.anchorPoint            = CGPointMake(0.0f, 0.5f);
    _bookCover.layer.position               = CGPointMake(self.view.center.x - CGRectGetWidth(_bookCover.frame)/2,
                                                          _bookCover.layer.position.y);
    _bookCover.layer.zPosition              = 1000.0f;
    
    //景深
    CATransform3D identityTransform = CATransform3DIdentity;  
    identityTransform.m34 = -1.0f / 800.0f;
    _bookCover.layer.transform = identityTransform;
    
    [_bookCover.layer addAnimation:curlAnimation forKey:@"curlBookCover"];
}

#pragma mark -
#pragma mark CAanimation delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    self.navBar.topItem.rightBarButtonItem.enabled = YES;
}

@end
