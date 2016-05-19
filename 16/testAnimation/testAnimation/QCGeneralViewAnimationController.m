// ################################################################################//
//		文件名 : QCGeneralViewAnimationController.m
// ################################################################################//
/*!
 @file		QCGeneralViewAnimationController.m
 @brief		普通动画视图控制器
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/10/03     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCGeneralViewAnimationController.h"

@implementation QCGeneralViewAnimationController
@synthesize imgBG1 = _imgBG1;
@synthesize imgBG2 = _imgBG2;
@synthesize animationView = _animationView;
@synthesize segmentControl = _segmentControl;
@synthesize navBar = _navBar;
@synthesize doneButton;
@synthesize isBlockAnimation = _isBlockAnimation;

- (void)viewWillAppear:(BOOL)animated
{
    if (_isBlockAnimation) {
        [_segmentControl setTitle:@"翻转(上)"
                forSegmentAtIndex:1];
        [_segmentControl setTitle:@"融合"
                forSegmentAtIndex:3];
    }
    else {
        [_segmentControl setTitle:@"翻转(右)"
                forSegmentAtIndex:1];
        [_segmentControl setTitle:@"翻页(下)"
                forSegmentAtIndex:3];
    }
}

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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark Action
- (IBAction)actClose:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actAnimation:(id)sender
{
    self.navBar.topItem.rightBarButtonItem.enabled = NO;
    
    if (!_isBlockAnimation) {
        switch (_segmentControl.selectedSegmentIndex) {
            case 0:
                [self animationFlipLeft];
                break;
            case 1:
                [self animationFlipRight];
                break;     
            case 2:
                [self animationCurlUp];
                break;   
            case 3:
                [self animationCurlDown];
                break;   
            default:
                break;
        }
    }
    else {
        switch (_segmentControl.selectedSegmentIndex) {
            case 0:
                [self animationFlipLeftBlock];
                break;
            case 1:
                [self animationFlipTopBlock];
                break;     
            case 2:
                [self animationCurlUpBlock];
                break;   
            case 3:
                [self animationDissolveBlock];
                break;   
            default:
                break;
        }
    }
}

#pragma mark -
#pragma mark General Animation
- (void)animationFlipLeft
{    
    [self generalAnimations:@"FlipLeft"
              transtionType:UIViewAnimationTransitionFlipFromRight];
}

- (void)animationFlipRight
{    
    [self generalAnimations:@"FlipRight"
              transtionType:UIViewAnimationTransitionFlipFromLeft];
}

- (void)animationCurlUp
{    
    [self generalAnimations:@"CurlUp"
              transtionType:UIViewAnimationTransitionCurlUp];
}

- (void)animationCurlDown
{
    [self generalAnimations:@"CurlDown"
              transtionType:UIViewAnimationTransitionCurlDown];
}

- (void)generalAnimations:(NSString*)animationName
            transtionType:(UIViewAnimationTransition)transtion
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:animationName 
                    context:context];
    [UIView setAnimationDuration:0.5f];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:transtion
                           forView:self.animationView 
                             cache:YES];
    [_animationView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationFinished:)];
	[UIView commitAnimations];
}

#pragma mark -
#pragma mark Block Animation
- (void)animationFlipLeftBlock
{
    [self blockAnimations:@"FlipLeft"
            transtionType:UIViewAnimationOptionTransitionFlipFromRight]; 
}

- (void)animationFlipTopBlock
{
    [self blockAnimations:@"FlipTop"
            transtionType:UIViewAnimationOptionTransitionFlipFromBottom]; 
}

- (void)animationCurlUpBlock
{
    [self blockAnimations:@"CurlUp"
            transtionType:UIViewAnimationOptionTransitionCurlUp]; 
}

- (void)animationDissolveBlock
{
    [self blockAnimations:@"Dissolve"
            transtionType:UIViewAnimationOptionTransitionCrossDissolve]; 
}

- (void)blockAnimations:(NSString*)animationName
          transtionType:(UIViewAnimationOptions)transtion
{
    UIViewAnimationOptions options = transtion | UIViewAnimationOptionCurveEaseIn;
    [UIView transitionWithView:_animationView
                      duration:0.5f
                       options:options
                    animations:^{
                        [_animationView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
                    } completion:^(BOOL finished) {
                        self.navBar.topItem.rightBarButtonItem.enabled = YES;
                    }];

}

#pragma mark -
#pragma mark animation delegate
- (void) animationFinished: (id) sender {
    self.navBar.topItem.rightBarButtonItem.enabled = YES;
}

@end
