// ################################################################################//
//		文件名 : QCCAViewAnimationController.m
// ################################################################################//
/*!
 @file		QCCAViewAnimationController.m
 @brief		CA动画视图控制器
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/10/03     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCCAViewAnimationController.h"
#import <QuartzCore/QuartzCore.h>

@implementation QCCAViewAnimationController
@synthesize imgBG1 = _imgBG1;
@synthesize imgBG2 = _imgBG2;
@synthesize animationView = _animationView;
@synthesize segmentControl = _segmentControl;
@synthesize navBar = _navBar;
@synthesize doneButton;

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.imgBG1 = nil;
    self.imgBG2 = nil;
    self.animationView = nil;
    self.navBar = nil;
    self.doneButton = nil;
    self.segmentControl = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
    
    switch (_segmentControl.selectedSegmentIndex) {
        case 0:
            [self animationMoveIn];
            break;
        case 1:
            [self animationPush];
            break;     
        case 2:
            [self animationReveal];
            break;   
        case 3:
            [self animationFade];
            break;   
        default:
            break;
    }
}

#pragma mark -
#pragma mark CA Animation
- (void)animationMoveIn
{    
    [self generalAnimations:@"MoveIn"
            CATranstionType:kCATransitionMoveIn];
}

- (void)animationPush
{    
    [self generalAnimations:@"Push"
            CATranstionType:kCATransitionPush];
}

- (void)animationReveal
{    
    [self generalAnimations:@"Reveal"
            CATranstionType:kCATransitionReveal];
}

- (void)animationFade
{
    [self generalAnimations:@"Fade"
            CATranstionType:kCATransitionFade];
}

- (void)generalAnimations:(NSString*)animationName
          CATranstionType:(NSString*)transtionType
{
    CATransition *myTransition  = [CATransition animation];
    myTransition.duration       = 0.5f;
    myTransition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

    NSArray *arrCommonTransSubtypes = [NSArray arrayWithObjects:kCATransitionFromLeft, 
                                              kCATransitionFromRight,
                                              kCATransitionFromTop,
                                              kCATransitionFromBottom,
                                              nil];
    myTransition.type       = transtionType;
    myTransition.subtype    = [arrCommonTransSubtypes objectAtIndex:(random()%4)];
    myTransition.delegate   = self;

	[_animationView.layer addAnimation:myTransition forKey:animationName];	
    [_animationView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
}

#pragma mark -
#pragma mark CAanimation delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
	self.navBar.topItem.rightBarButtonItem.enabled = YES;
}


@end
