// ################################################################################//
//		文件名 : QCCAViewPrivateAnimationController.m
// ################################################################################//
/*!
 @file		QCCAViewPrivateAnimationController.m
 @brief		CA私有动画视图控制器
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/10/03     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCCAViewPrivateAnimationController.h"
#import <QuartzCore/QuartzCore.h>

typedef enum privateAnimation{
    kFlip = 0,
    kSuckEffect,
    kCube,
    kRippleEffect,
    kPageCurl,
    kPageUnCurl,
    kCameraOpen,
    kCameraClose
} privateAnimationType;

@implementation QCCAViewPrivateAnimationController {
    privateAnimationType _type;
}
@synthesize imgBG1 = _imgBG1;
@synthesize imgBG2 = _imgBG2;
@synthesize animationView = _animationView;
@synthesize btnSelectAnimation = _btnSelectAnimation;
@synthesize navBar = _navBar;
@synthesize doneButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _type = kFlip;
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
    self.btnSelectAnimation = nil;
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
    
    switch (_type) {
        case kFlip:
            [self privateAnimations:@"flip"
                 withStopOnProgress:1.0f
                    CATranstionType:@"oglFlip"];
            break;
        case kSuckEffect:
            [self privateAnimations:@"suckEffect"
                 withStopOnProgress:1.0f
                    CATranstionType:@"suckEffect"];
            break;     
        case kCube:
            [self privateAnimations:@"cube"
                 withStopOnProgress:1.0f
                    CATranstionType:@"cube"];
            break;   
        case kRippleEffect:
            [self privateAnimations:@"rippleEffect"
                 withStopOnProgress:1.0f
                    CATranstionType:@"rippleEffect"];
            break; 
        case kPageCurl:
            [self privateAnimations:@"pageCurl"
                 withStopOnProgress:0.6f
                    CATranstionType:@"pageCurl"];
            break;
        case kPageUnCurl:
            [self privateAnimations:@"pageUnCurl"
                 withStopOnProgress:0.4f
                    CATranstionType:@"pageUnCurl"];
            break;  
        case kCameraOpen:
            [self privateAnimations:@"cameraOpen"
                 withStopOnProgress:1.0f
                    CATranstionType:@"cameraIrisHollowOpen"];
            break;  
        case kCameraClose:
            [self privateAnimations:@"cameraClose"
                 withStopOnProgress:1.0f
                    CATranstionType:@"cameraIrisHollowClose"];
            break;  
        default:
            break;
    }
}

- (IBAction)actChooseAnimation:(id)sender
{
    UIActionSheet   *sheet = [[[UIActionSheet alloc] initWithTitle:@"私有动画" 
                                                         delegate:self
                                                cancelButtonTitle:@"取消" 
                                           destructiveButtonTitle:nil 
                                                 otherButtonTitles:@"翻转", @"吸入", @"方盒", @"波纹", @"卷上去", @"卷下来", @"开镜头", @"关镜头", nil] autorelease];
    [sheet showInView:self.view];
}

#pragma mark -
#pragma mark UIActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *strTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if (buttonIndex < actionSheet.numberOfButtons - 1) {
        [_btnSelectAnimation setTitle:[strTitle stringByAppendingString:@"动画"]
                             forState:UIControlStateNormal];
        _type = buttonIndex;
    }
}

#pragma mark -
#pragma mark private CA Animation
- (void)privateAnimations:(NSString*)animationName
       withStopOnProgress:(float)progress
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
    myTransition.type                   = transtionType;
    myTransition.subtype                = [arrCommonTransSubtypes objectAtIndex:(random()%4)];
    myTransition.delegate               = self;
    myTransition.speed                  = 1.0f;
    
    if (progress < 1.0f) {
        myTransition.fillMode               = kCAFillModeForwards;
        myTransition.endProgress            = progress;
        myTransition.removedOnCompletion    = NO;
    }
    
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
