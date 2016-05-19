// ################################################################################//
//		文件名 : QCViewController.m
// ################################################################################//
/*!
 @file		QCViewController.m
 @brief		显示视图类
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/10/05     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation QCViewController
@synthesize whiteView = _whiteView;
@synthesize textView = _textView;
@synthesize txtUserName = _txtUserName;
@synthesize txtPassword = _txtPassword;
@synthesize contentView = _contentView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //键盘显示的回调函数
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShown:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    //键盘隐藏的回调函数
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)dealloc{
    SAFE_RELEASE(_whiteView)
    SAFE_RELEASE(_textView)
    SAFE_RELEASE(_txtUserName)
    SAFE_RELEASE(_txtPassword)
    SAFE_RELEASE(_contentView)

    [super dealloc];
}

#pragma mark -
#pragma mark iOS6.0 prior
- (void)viewDidUnload {
    [super viewDidUnload];
    
    self.whiteView          = nil;
    self.textView           = nil;
    self.contentView        = nil;
    self.txtUserName        = nil;
    self.txtPassword        = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

#pragma mark -
#pragma mark iOS6.0 later
- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return  UIInterfaceOrientationMaskAll;
}

#pragma mark -
#pragma mark Rotation Delegate
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration
{
    //开始旋转
    _rotating = YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    //旋转结束
    _rotating = NO;
}

#pragma mark -
#pragma mark UITextField Delegate
//焦点进入UITextField后，可以开始输入的回调函数
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    //当前焦点的UITextField
    _activeTextField = textField;
    
    //如果没有显示键盘，那移动的任务交给keyboardWillShown：来做，这里return。
    //否则的话，移动的任务在这里完成
    if (!_keyboardShowing) {
        return;
    }
    
    //显然，能够走到这里，是因为“Next”的关系
    //我们要和keyboardWillShown里面写的一样，将有效的UITextField位置取出来
    //检查是否需要位移
    CGRect rectTextField = [[_activeTextField superview] convertRect:_activeTextField.frame
                                                              toView:self.view];
    
    //contentView的移动必要性检查和执行移动
    [self moveContentView:self.contentView
             keyboardSize:_sizeKeyboard
  textFieldRectOnMainView:rectTextField];
}

//点击UITextField对应的键盘的回车键的回调函数
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //按了“Next”
    if (textField == _txtUserName) {
        [_txtPassword becomeFirstResponder];
        return YES;
    }
    
    //按了"Done"
    if (textField == _txtPassword){
        [self.view endEditing:YES];
        return YES;
    }
    
    return YES;
}

#pragma mark -
#pragma mark Utility
- (void)moveContentView:(UIView*)aView
           keyboardSize:(CGSize)sizeKeyboard
textFieldRectOnMainView:(CGRect)rectTextField
{
    //UITextField当前是否完全显示出来？
    if (CGRectContainsRect(CGRectMake(0.0f,
                                      0.0f,
                                      CGRectGetWidth(self.view.frame),
                                      CGRectGetHeight(self.view.frame) - sizeKeyboard.height),
                           rectTextField)) {
        //不需要移动
        return;
    }
    
    //计算需要移动的距离
    float fDelta = sizeKeyboard.height -
    //之所以不适用self.view.frame.因为self.view作为程序的根视图
    //所以大小一直是竖屏的大小，横屏时系统只对根视图的transform进行配置，我们去高度不方便。
    //既然contentView高度不变，只变Y轴起始点，那不如直接取contentView的高度
    CGRectGetHeight(aView.frame) + 
    CGRectGetMinY(rectTextField) +
    CGRectGetHeight(rectTextField);
    
    //移动
    [UIView animateWithDuration:.3f
                     animations:^{
                         aView.frame = CGRectMake(CGRectGetMinX(aView.frame),
                                                  CGRectGetMinY(aView.frame) - fDelta,
                                                  CGRectGetWidth(aView.frame),
                                                  CGRectGetHeight(aView.frame));
                     } completion:^(BOOL finished) {
                         
                     }];
}

#pragma mark -
#pragma mark Keyboard Notification
- (void)keyboardWillShown:(NSNotification*)aNotification
{
    //设置键盘显示中的Flag
    _keyboardShowing = YES;
    
    //收取消息内容并获得键盘大小
    NSDictionary    *info       = [aNotification userInfo];
    NSValue         *aValue     = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    //当设备横屏时，直接取键盘的大小并不准确
    //因为系统为键盘的视图增加了一个transform的内容。
    //所以这里有必要进行一次座标转换，以保证键盘大小在特定设备方向上的准确
    CGSize  keyboardSize = [self.view convertRect:[aValue CGRectValue]
                                         fromView:nil].size;
    
    //将键盘大小记录下来
    _sizeKeyboard =CGSizeMake(keyboardSize.width,
                              keyboardSize.height);
    
    //因为要计算UITextField是不是被键盘隐藏了，而键盘是显示在UIWindow上的。
    //所以UITextField的座标也要转换到self.view上，在同一层面上的座标比较这样才有意义
    CGRect rectTextField = [[_activeTextField superview] convertRect:_activeTextField.frame
                                                              toView:self.view];
    
    //进行移动
    [self moveContentView:self.contentView  //移动谁
             keyboardSize:_sizeKeyboard     //是否需要移动的依据，即键盘大小
  textFieldRectOnMainView:rectTextField];   //UITextField的有效位置
}

- (void)keyboardWillHidden:(NSNotification*)aNotification
{
    //一般情况下，此回调函数中首先需要将“当前编辑中UITextField”清空（置nil）
    //不过当UITextField处于编辑中（键盘显示中）时，同时发生了旋转的话，
    //则系统对于键盘事件会先调用此回调函数，再调用keyboardWillShown回调函数。也就是说显示中的键盘在旋转设备时先收起再展开。
    //所以“当前编辑中UITextField”清空的任务需要将“旋转中”排除在外，
    //以避免之后进入keyboardWillShown时没有“当前编辑中UITextField”导致程序不做界面位置调整。
    if (!_rotating) {
        //没有焦点中的UITextField了
        _activeTextField = nil;
    }

    //设置键盘未显示的Flag
    _keyboardShowing = NO;
    
    //将contentView的座标移动回(0.0, 0.0)点
    [UIView animateWithDuration:.3f
                     animations:^{
                         self.contentView.frame = CGRectMake(0.0f,
                                                             0.0f,
                                                             CGRectGetWidth(self.contentView.frame),
                                                             CGRectGetHeight(self.contentView.frame));
                     } completion:^(BOOL finished) {
                         
                     }];
    
}


@end
