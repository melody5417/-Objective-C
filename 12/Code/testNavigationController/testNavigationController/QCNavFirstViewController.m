// ################################################################################//
//		文件名 : QCNavFirstViewController.h
// ################################################################################//
/*!
 @file		QCNavFirstViewController.h
 @brief		导航控制器中位于根视图之后的首个视图控制器实现文件
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/11/17     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCNavFirstViewController.h"
#import "QCNavMultiControlsViewController.h"
#import "QCNavToolBarViewController.h"
#import "QCNavResizeViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation QCNavFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //初始化导航栏内容
    [self initNavBar];
}

- (void)dealloc
{
    if (_mySegments) {
        [_mySegments release];
    }
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated
{
    //将导航控制器的工具栏更新为自己的工具栏，用于显示
    [self updateToolBar];
    
    //super继续，不破坏原系统流程
    [super viewWillAppear:animated];
}

#pragma mark -
#pragma mark initial
- (void)initNavBar
{
    //
    //UISegmentControl初始化
    //创建一个UISegmentControl控件
    UISegmentedControl  *aSegment = [[UISegmentedControl alloc] initWithFrame:CGRectMake(0.0f,
                                                                                         0.0f,
                                                                                         1000.0f,
                                                                                         30.0f)];
    //为控件新增三段内容
    [aSegment insertSegmentWithTitle:@"多控件"
                             atIndex:0
                            animated:NO];
    [aSegment insertSegmentWithTitle:@"工具栏"
                             atIndex:1
                            animated:NO];
    [aSegment insertSegmentWithTitle:@"动画&超大"
                             atIndex:2
                            animated:NO];
    //设置控件的式样
    [aSegment setSegmentedControlStyle:UISegmentedControlStyleBar];
    //设置控件首次被显示出来时，被选中的段号
    aSegment.selectedSegmentIndex = 0;
    //将UISegmentControl设置成当前导航栏中间的部分
    self.navigationItem.titleView = aSegment;
    
    //
    //为导航栏左边配置一个系统自带式样的按钮
    //按钮响应函数是actDone：
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                           target:self
                                                                                           action:@selector(actDone:)]
                                             autorelease];
    //
    //为导航栏右边配置一个系统自带式样的按钮
    //按钮响应函数是actNext：
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                                            target:self
                                                                                            action:@selector(actNext:)]
                                              autorelease];
    //
    //为下一层视图控制器的默认返回按钮配置式样
    self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"你快回来！"
                                                                              style:UIBarButtonItemStyleBordered
                                                                             target:self
                                                                             action:NULL]
                                             autorelease];
    
    //成员量指针
    if (!_mySegments) {
        _mySegments = aSegment;
    }
}

- (void)updateToolBar
{
    //初始化工具栏中的元素
    if (!_toolBarItems) {
        _toolBarItems = [[NSArray alloc] initWithObjects:[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                                        target:self
                                                                                                        action:@selector(actAdd:)] autorelease],
                         nil];
    }
    
    //配置工具栏的式样
    self.navigationController.toolbar.barStyle = UIBarStyleDefault;
    
    //显示工具栏
    [self.navigationController setToolbarHidden:NO
                                       animated:YES];
    
    //设置工具栏的元素
    if (self.toolbarItems != _toolBarItems) {
        self.toolbarItems = _toolBarItems;
    }
}

#pragma mark -
#pragma mark Action
- (IBAction)actBack:(id)sender {
    //将当前视图控制器推出栈
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actNext:(id)sender
{
    //根据分段控件的选项不同而去到不同的下一层视图控制器
    UIViewController    *aNewVC = nil;
    switch (_mySegments.selectedSegmentIndex) {
        case 0:
            aNewVC = [[[QCNavMultiControlsViewController alloc] initWithNibName:@"QCNavMultiControlsViewController"
                                                                         bundle:nil] autorelease];
            break;
        case 1:
            aNewVC = [[[QCNavToolBarViewController alloc] initWithNibName:@"QCNavToolBarViewController"
                                                                   bundle:nil] autorelease];
            aNewVC.wantsFullScreenLayout = YES;
            break;
        case 2:
            aNewVC = [[[QCNavResizeViewController alloc] initWithNibName:@"QCNavResizeViewController"
                                                                  bundle:nil] autorelease];
            
            //自定义动画
            CATransition *animation = [CATransition animation];
            animation.delegate = self;
            animation.duration = 0.5f;
            animation.timingFunction = UIViewAnimationCurveEaseInOut;
            animation.removedOnCompletion = NO;
            animation.type = @"pageCurl";
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
            
            [self.navigationController pushViewController:aNewVC animated:NO];
            
            return;
        default:
            break;
    }
    [self.navigationController pushViewController:aNewVC animated:YES];
}

//Done按钮的响应函数
- (IBAction)actDone:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"我是类<%@>", NSStringFromClass([self class])]
                                                    message:[NSString stringWithFormat:@"继续在<%@>方法中撰写按钮功能", NSStringFromSelector(_cmd)]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}

//Add按钮的响应函数
- (IBAction)actAdd:(id)sender
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
