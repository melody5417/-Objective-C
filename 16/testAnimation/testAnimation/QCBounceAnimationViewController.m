// ################################################################################//
//		文件名 : QCBounceAnimationViewController.m
// ################################################################################//
/*!
 @file		QCBounceAnimationViewController.m
 @brief		弹跳动画视图控制器
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/10/03     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCBounceAnimationViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation QCBounceAnimationViewController
@synthesize btnLogo = _btnLogo;
@synthesize navBar = _navBar;
@synthesize segmentControl = _segmentControl;
@synthesize doneButton;
@synthesize imgLighting = _imgLighting;

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.btnLogo = nil;
    self.navBar  = nil;
    self.segmentControl = nil;
    self.imgLighting = nil;
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
    [self stopLightingAnimation];
    
    switch (_segmentControl.selectedSegmentIndex) {
        case 0:
            self.navBar.topItem.rightBarButtonItem.enabled = NO;
            [self springAnimation];
            break;
        case 1:
            self.navBar.topItem.rightBarButtonItem.enabled = NO;
            [self bounceAnimation];
            break;   
        case 2:
            [self lightingAnimation];
            break;
        default:
            break;
    }
}

#pragma mark -
#pragma mark self attribute Animation
- (void)springAnimation
{
    CAKeyframeAnimation		*animation		= nil; 
	NSMutableArray			*arrTransform	= [NSMutableArray arrayWithCapacity:0];
	
	animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"]; 
	animation.duration = 0.5f; 
	animation.delegate = self;
    //CAKeyAnimation中，连接多个动画之间的式样
    animation.calculationMode = kCAAnimationLinear;

	[arrTransform addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5, 0.5, 1.0)]];
	[arrTransform addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.5, 1.5, 1.0)]]; 
	[arrTransform addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]]; 
	[arrTransform addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
	animation.values = arrTransform;
	[_btnLogo.layer addAnimation:animation forKey:@"bounce"]; 
}

- (void)bounceAnimation
{
	[CATransaction begin];
    [CATransaction setValue:[NSNumber numberWithFloat:2.0f] forKey:kCATransactionAnimationDuration];
	
    //缩小
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
	scaleAnimation.delegate = self;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    scaleAnimation.toValue = [NSNumber numberWithFloat:0.0];
	[_btnLogo.layer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
	
	//消失
    CABasicAnimation *fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeAnimation.toValue = [NSNumber numberWithFloat:0.0];
    fadeAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_btnLogo.layer addAnimation:fadeAnimation forKey:@"fadeAnimation"];
	
	//跳跃
    CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef positionPath = CGPathCreateMutable();
    CGPathMoveToPoint(positionPath, 
                      NULL, 
                      _btnLogo.layer.position.x,
                      _btnLogo.layer.position.y);
    CGPathAddQuadCurveToPoint(positionPath, 
                              NULL, 
                              _btnLogo.layer.position.x, 
                              - _btnLogo.layer.position.y * 0.3f, 
                              _btnLogo.layer.position.x, 
                              _btnLogo.layer.position.y);
    CGPathAddQuadCurveToPoint(positionPath, 
                              NULL, 
                              _btnLogo.layer.position.x, 
                              _btnLogo.layer.position.y * 0.0f, 
                              _btnLogo.layer.position.x, 
                              _btnLogo.layer.position.y);
    CGPathAddQuadCurveToPoint(positionPath,
                              NULL,
                              _btnLogo.layer.position.x, 
                               _btnLogo.layer.position.y * 0.5f,
                              _btnLogo.layer.position.x, 
                              _btnLogo.layer.position.y);
    bounceAnimation.path = positionPath;
    CFRelease(positionPath);
    bounceAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_btnLogo.layer addAnimation:bounceAnimation forKey:@"bounceAnimation"];
    
	[CATransaction commit];	
}

- (void)lightingAnimation
{	
	if ([self.imgLighting.layer animationForKey:@"Lighting"] == nil) {
		CAKeyframeAnimation *animationLighting = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
		animationLighting.duration				= 1.0f;
		animationLighting.autoreverses			= YES;
		animationLighting.repeatCount			= HUGE_VALF;
		
		NSMutableArray	*arrOpacity	= [NSMutableArray arrayWithCapacity:0];
		[arrOpacity addObject:[NSNumber numberWithBool:0]];
		[arrOpacity addObject:[NSNumber numberWithBool:1]];
		animationLighting.values = arrOpacity;
		[self.imgLighting.layer addAnimation:animationLighting
                                      forKey:@"Lighting"];
	}
    
	
	self.imgLighting.layer.speed = 1.0f;
}

- (void)stopLightingAnimation
{
	if ([self.imgLighting.layer animationForKey:@"Lighting"] == nil) {
        return;
    }
    
    self.imgLighting.layer.speed = 0.0f;
}

#pragma mark -
#pragma mark CAanimation delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
	self.navBar.topItem.rightBarButtonItem.enabled = YES;
}


@end
