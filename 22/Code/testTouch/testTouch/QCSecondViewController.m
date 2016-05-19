// ################################################################################//
//		文件名 : QCSecondViewController.m
// ################################################################################//
/*!
 @file		QCSecondViewController.m
 @brief		第二个功能视图控制器
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/11/04     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCSecondViewController.h"

@implementation QCSecondViewController
@synthesize labGestureInfo = _labGestureInfo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Touch", @"Touch");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    
    return self;
}

- (void)dealloc
{
    [_labGestureInfo release];
    [super dealloc];
}

- (void)updateInfor:(UITouch*)aTouch
     withMethodName:(NSString*)aMethodName
{
    NSString    *strPhase   = @"";
    //判断触摸事件的阶段
    switch (aTouch.phase) {
        case UITouchPhaseBegan:
            strPhase = @"UITouchPhaseBegan";
            break;
        case UITouchPhaseMoved:
            strPhase = @"UITouchPhaseMoved";
            break;
        case UITouchPhaseCancelled:
            strPhase = @"UITouchPhaseCancelled";
            break;
        case UITouchPhaseEnded:
            strPhase = @"UITouchPhaseEnded";
            break;
        case UITouchPhaseStationary:
            strPhase = @"UITouchPhaseStationary";
            break;
        default:
            break;
    }
    
    //将当前的触摸响应函数名，当前触摸点座标，上一次触摸响应点座标，
    //点击次数，触摸事件的时间戳和触摸阶段全部显示到街面上
    self.labGestureInfo.text = [NSString stringWithFormat:@"[%@]:\nNowLocation:[%@]\nPreviousLocation:[%@]\nTapCount:[%d]\nTimeStamp:[%f]\nPhase:[%@]",
                                aMethodName,
                                [NSValue valueWithCGPoint:[aTouch locationInView:self.view]],
                                [NSValue valueWithCGPoint:[aTouch previousLocationInView:self.view]],
                                aTouch.tapCount,
                                aTouch.timestamp,
                                strPhase];

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{    
    [self updateInfor:[touches anyObject]
       withMethodName:@"touchesBegan"];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self updateInfor:[touches anyObject]
       withMethodName:@"touchesMoved"];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self updateInfor:[touches anyObject]
       withMethodName:@"touchesEnded"];
}

@end
