// ################################################################################//
//		文件名 : QCFirstViewController.m
// ################################################################################//
/*!
 @file		QCFirstViewController.m
 @brief		第一个功能视图控制器
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/11/04     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCFirstViewController.h"

@interface QCFirstViewController () <UIPickerViewDataSource, UIPickerViewDelegate> {
    NSMutableArray  *_arrGestureRec;
    CGPoint         _pntImageCenter;
    CGFloat         _fRadian;
}
@end

@implementation QCFirstViewController
@synthesize vGesture = _vGesture;
@synthesize labGestureInfo = _labGestureInfo;
@synthesize picker = _picker;
@synthesize imgTest = _imgTest;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Gesture", @"Gesture");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _arrGestureRec  = [[NSMutableArray alloc] initWithCapacity:0];
    _pntImageCenter = self.imgTest.center;
    
    [self updateGestureRecognizer];
}

- (void)dealloc
{
    SAFE_RELEASE(_arrGestureRec)
    SAFE_RELEASE(_picker)
    SAFE_RELEASE(_labGestureInfo)
    SAFE_RELEASE(_vGesture)
    SAFE_RELEASE(_imgTest)
    
    [super dealloc];
}

- (void)resetConfiguration
{
    //将当前所有手势反注册
    if (_arrGestureRec && _arrGestureRec.count > 0) {
        for (UIGestureRecognizer *aGesture in _arrGestureRec) {
            [self.vGesture removeGestureRecognizer:aGesture];
        }
        [_arrGestureRec removeAllObjects];
    }
    
    //将图片的状态重置
    //包括矩阵的重置，中心点的重置，显示与否的重置等等
    self.imgTest.transform = CGAffineTransformIdentity;
    self.imgTest.hidden = NO;
    self.imgTest.userInteractionEnabled = YES;
    self.imgTest.center = CGPointMake(CGRectGetWidth(self.vGesture.frame)/2,
                                      CGRectGetHeight(self.vGesture.frame)/2);
    _pntImageCenter = self.imgTest.center;
    _fRadian        = 0.0f;
    
    //将手势信息的内容重置
    self.labGestureInfo.text = @"";
}

#pragma mark -
#pragma mark Gesture recognizer
- (void)updateGestureRecognizer
{
    //重置手势识别的状态
    [self resetConfiguration];
    
    UIGestureRecognizer *aGesture = nil;
    //检测当前选中的手势
    switch ([self.picker selectedRowInComponent:0]) {
        case kTapGesture:
            self.imgTest.hidden = YES;
            self.imgTest.userInteractionEnabled = NO;
            
            //四种不同要求的Tap手势识别器注册
            aGesture = (UITapGestureRecognizer*)[[[UITapGestureRecognizer alloc] initWithTarget:self
                                                               action:@selector(tapGesture1:)] autorelease];
            ((UITapGestureRecognizer*)aGesture).numberOfTapsRequired    = 1;
            ((UITapGestureRecognizer*)aGesture).numberOfTouchesRequired = 1;
            [_arrGestureRec addObject:aGesture];
            
            aGesture = [[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                action:@selector(tapGesture2:)] autorelease];
            ((UITapGestureRecognizer*)aGesture).numberOfTapsRequired    = 2;
            ((UITapGestureRecognizer*)aGesture).numberOfTouchesRequired = 1;
            [_arrGestureRec addObject:aGesture];

            aGesture = [[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                action:@selector(tapGesture3:)] autorelease];
            ((UITapGestureRecognizer*)aGesture).numberOfTapsRequired    = 3;
            ((UITapGestureRecognizer*)aGesture).numberOfTouchesRequired = 1;
            [_arrGestureRec addObject:aGesture];
            
            aGesture = [[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                action:@selector(tapGesture4:)] autorelease];
            ((UITapGestureRecognizer*)aGesture).numberOfTapsRequired    = 1;
            ((UITapGestureRecognizer*)aGesture).numberOfTouchesRequired = 2;
            [_arrGestureRec addObject:aGesture];
            break;
        case kPinchGesture:
            //图片供“捏”手势的效果验证
            self.imgTest.hidden = NO;
            self.imgTest.userInteractionEnabled = YES;
            
            //pinch手势识别器注册
            aGesture = [[[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                                 action:@selector(pinchGesture:)] autorelease];
            [_arrGestureRec addObject:aGesture];
            break;
        case kPanGesture:
            //图片供“平移”手势的效果验证
            self.imgTest.hidden = NO;
            self.imgTest.userInteractionEnabled = YES;
            
            //Pan手势识别器注册
            aGesture = [[[UIPanGestureRecognizer alloc] initWithTarget:self
                                                               action:@selector(panGesture:)] autorelease];
            //从1个手指到多个手指，均符合手势识别的条件
            ((UIPanGestureRecognizer*)aGesture).minimumNumberOfTouches = 1;
            ((UIPanGestureRecognizer*)aGesture).maximumNumberOfTouches = UINT_MAX;
            [_arrGestureRec addObject:aGesture];
            break;
        case kSwipeGesture:
            self.imgTest.hidden = YES;
            self.imgTest.userInteractionEnabled = NO;
            
            //Swipe手势识别器注册
            //一共提供4个，分别代表4个方向
            //手指的个数均设置成1个。
            aGesture = [[[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                 action:@selector(swipeGestureLeft:)] autorelease];
            ((UISwipeGestureRecognizer*)aGesture).direction = UISwipeGestureRecognizerDirectionLeft;
            ((UISwipeGestureRecognizer*)aGesture).numberOfTouchesRequired = 1;
            [_arrGestureRec addObject:aGesture];
            
            aGesture = [[[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                  action:@selector(swipeGestureRight:)] autorelease];
            ((UISwipeGestureRecognizer*)aGesture).direction = UISwipeGestureRecognizerDirectionRight;
            ((UISwipeGestureRecognizer*)aGesture).numberOfTouchesRequired = 1;
            [_arrGestureRec addObject:aGesture];
            
            aGesture = [[[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                  action:@selector(swipeGestureUp:)] autorelease];
            ((UISwipeGestureRecognizer*)aGesture).direction = UISwipeGestureRecognizerDirectionUp;
            ((UISwipeGestureRecognizer*)aGesture).numberOfTouchesRequired = 1;
            [_arrGestureRec addObject:aGesture];
            
            aGesture = [[[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                  action:@selector(swipeGestureDown:)] autorelease];
            ((UISwipeGestureRecognizer*)aGesture).direction = UISwipeGestureRecognizerDirectionDown;
            ((UISwipeGestureRecognizer*)aGesture).numberOfTouchesRequired = 1;
            [_arrGestureRec addObject:aGesture];
            break;
        case kRotationGesture:
            //图片供“旋转”手势的效果验证
            self.imgTest.hidden = NO;
            self.imgTest.userInteractionEnabled = YES;
            
            //Rotation手势识别器注册
            aGesture = [[[UIRotationGestureRecognizer alloc] initWithTarget:self
                                                                    action:@selector(rotateGesture:)] autorelease];
            [_arrGestureRec addObject:aGesture];
            break;
        case kLongPressGesture:
            self.imgTest.hidden = YES;
            self.imgTest.userInteractionEnabled = NO;
            
            //LongPress手势识别器注册
            //手指的个数均设置成1个,长按时可以移动的误差为10，并且2秒后响应。
            aGesture = [[[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                     action:@selector(longPressGesture:)] autorelease];
            ((UILongPressGestureRecognizer*)aGesture).numberOfTapsRequired = 0;
            ((UILongPressGestureRecognizer*)aGesture).numberOfTouchesRequired = 1;
            ((UILongPressGestureRecognizer*)aGesture).allowableMovement = 10.0f;
            ((UILongPressGestureRecognizer*)aGesture).minimumPressDuration = 2.0f;
            [_arrGestureRec addObject:aGesture];
            break;
        default:
            return;
    }
    
    //将所有手势注册到视图上
    if (_arrGestureRec && _arrGestureRec.count > 0) {
        for (UIGestureRecognizer *aGesture in _arrGestureRec) {
            [self.vGesture addGestureRecognizer:aGesture];
        }
    }
}

- (void)tapGesture1:(UITapGestureRecognizer*)aTapGes {
    NSLog(@"tapGesture1");
    self.labGestureInfo.text = [NSString stringWithFormat:@"检测到Tap手势, \n点击数:[1]\n手指数:[1]"];
}

- (void)tapGesture2:(UITapGestureRecognizer*)aTapGes {
    NSLog(@"tapGesture2");
    self.labGestureInfo.text = [NSString stringWithFormat:@"检测到Tap手势, \n点击数:[2]\n手指数:[1]"];
}

- (void)tapGesture3:(UITapGestureRecognizer*)aTapGes {
    NSLog(@"tapGesture3");
    self.labGestureInfo.text = [NSString stringWithFormat:@"检测到Tap手势, \n点击数:[3]\n手指数:[1]"];
}

- (void)tapGesture4:(UITapGestureRecognizer*)aTapGes {
    NSLog(@"tapGesture4");
    self.labGestureInfo.text = [NSString stringWithFormat:@"检测到Tap手势, \n点击数:[1]\n手指数:[2]"];
}

- (void)pinchGesture:(UIPinchGestureRecognizer*)aPinchGes
{
    //UIPinchGestureRecognizer提供scale和velocity两个属性
    self.labGestureInfo.text = [NSString stringWithFormat:@"检测到Pinch手势, \n缩放比例:[%f]\n速率:[%f]",
                                aPinchGes.scale,
                                aPinchGes.velocity];
    
    //依据scale的值，对图片进行缩放
    self.imgTest.transform = CGAffineTransformMakeScale(aPinchGes.scale,
                                                        aPinchGes.scale);
}

- (void)panGesture:(UIPanGestureRecognizer*)aPanGes
{
    //UIPanGestureRecognizer提供了手势触摸屏幕的座标位置换算的API
    //能够方便的在多个存在父子关系视图之间进行切换运算
    self.labGestureInfo.text = [NSString stringWithFormat:@"检测到Pan手势, \n位移:[%@]",
                                [NSValue valueWithCGPoint:[aPanGes translationInView:self.vGesture]]];
    
    CGPoint translate = [aPanGes translationInView:self.vGesture];
    switch ([aPanGes state]) {
        case UIGestureRecognizerStateBegan:
            break;
        case UIGestureRecognizerStateChanged:
            //移动时，改变图片座标
            self.imgTest.center = CGPointMake(_pntImageCenter.x + translate.x,
                                              _pntImageCenter.y + translate.y);
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
            //移动完，将当前图片座标记录到成员量中，供下次使用
            _pntImageCenter = self.imgTest.center;
            break;
        default:
            break;
    }
}

- (void)swipeGestureLeft:(UISwipeGestureRecognizer*)aSwipeGes {
    self.labGestureInfo.text = @"检测到Swipe手势: 方向:[向左]";
}
- (void)swipeGestureRight:(UISwipeGestureRecognizer*)aSwipeGes {
    self.labGestureInfo.text = @"检测到Swipe手势: 方向:[向右]";
}
- (void)swipeGestureUp:(UISwipeGestureRecognizer*)aSwipeGes {
    self.labGestureInfo.text = @"检测到Swipe手势: 方向:[向上]";
}
- (void)swipeGestureDown:(UISwipeGestureRecognizer*)aSwipeGes {
    self.labGestureInfo.text = @"检测到Swipe手势: 方向:[向下]";
}

#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
- (void)rotateGesture:(UIRotationGestureRecognizer*)aRotationGes
{
    //UIRotationGestureRecognizer提供rotation和velocity两个属性
    self.labGestureInfo.text = [NSString stringWithFormat:@"检测到Rotation手势, \n旋转角度:[%.2f]\n速率:[%.2f]",
                                RADIANS_TO_DEGREES(aRotationGes.rotation),
                                aRotationGes.velocity];
    
    //依据rotation的值，对图片进行旋转
    self.imgTest.transform = CGAffineTransformRotate(self.imgTest.transform, aRotationGes.rotation);
    aRotationGes.rotation = 0;

}

- (void)longPressGesture:(UILongPressGestureRecognizer*)aLongPressGes
{
    //UILongPressGestureRecognizer访问minimumPressDuration属性
    self.labGestureInfo.text = [NSString stringWithFormat:@"检测到LongPress手势, \n持续时间:[%.2f]",
                                aLongPressGes.minimumPressDuration];
}

#pragma mark -
#pragma mark Pick DataSource
//只需要1列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

//返回支持的手势总数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return kGestureSupportingCount;
}

#pragma mark -
#pragma mark Pick Delegate
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    //返回不同的标题
    switch (row) {
        case kTapGesture:
            return @"Tap (点击)";
        case kPinchGesture:
            return @"Pinch (捏)";
        case kPanGesture:
            return @"Pan (慢速平移)";
        case kSwipeGesture:
            return @"Swipe (快速滑动)";
        case kRotationGesture:
            return @"Rotation (旋转)";
        case kLongPressGesture:
            return @"LongPress (长按)";
        default:
            return @"?";
            break;
    }
}

//选择指定Picker的选项后，进行后续处理
- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component
{
    [self updateGestureRecognizer];
}
@end
