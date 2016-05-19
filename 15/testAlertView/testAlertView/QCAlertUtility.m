// ################################################################################//
//		文件名 : QCAlertUtility.m
// ################################################################################//
/*!
 @file		QCAlertUtility.m
 @brief		Alert类型的警告框
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/08/27     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCAlertUtility.h"
#import <CoreGraphics/CoreGraphics.h>

QCAlertUtility *_gAlertInstance = nil;
@implementation QCAlertUtility

+ (id)defaultAlert
{
    if (_gAlertInstance == nil) {
        _gAlertInstance = [[QCAlertUtility alloc] init];
    }
    
    return _gAlertInstance;
}

#pragma mark -
#pragma mark Normal
+ (void)showNormalAlert
{
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"你好" 
                                                    message:@"我是普通警告框" 
                                                   delegate:nil
                                          cancelButtonTitle:@"好的" 
                                           otherButtonTitles: nil] autorelease];
    alert.tag = kAlertNormalType;
    [alert show];
}

#pragma mark DelegateAlert
- (void)showDelegateAlert
{
    //最多可以有五个按钮，更多的话界面会有异常情况发生
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"你好" 
                                                     message:@"我的警告框使用了代理" 
                                                    delegate:self
                                           cancelButtonTitle:@"好的" 
                                           otherButtonTitles:
                           @"不好", 
                           //有最小字体限制，当显示不下则中间以省略号代替
                           @"到底好不好到底好不好到底好不好到底好不好到底好不好到底好不好到底好不好",                          
                           @"不好就是不好", 
                           @"谁说好了", 
                           nil] 
                          autorelease];
    alert.tag = kAlertUseDelegateType;
    [alert show];
}

#pragma mark NoButton
- (void)showNoButtonAlert
{
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"请稍等" 
                                                     message:nil
                                                    delegate:self
                                           cancelButtonTitle:nil 
                                           otherButtonTitles: nil] autorelease];
    alert.tag = kAlertNoButtonType;
    [alert show];
    
    //无敌风火轮
    UIActivityIndicatorView *actIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:
                                             UIActivityIndicatorViewStyleWhiteLarge];
    //位置设置好
    actIndicator.center = CGPointMake(CGRectGetWidth(alert.bounds)/2, 
                                      CGRectGetHeight(alert.bounds) - 40.0f);
    
    //动起来
    [actIndicator startAnimating];
    [alert addSubview:actIndicator];
    [actIndicator release];
    
    
    [self performSelector:@selector(dismissAlert:)
               withObject:alert
               afterDelay:3.0f];
}

- (void)dismissAlert:(UIAlertView*)aAlertView
{
    if (aAlertView) {
        [aAlertView dismissWithClickedButtonIndex:0 animated:YES];
    }
}

#pragma mark BlockAlert
- (void)showBlockAlert
{
    _currentLoop = CFRunLoopGetCurrent();
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"你好" 
                                                     message:@"我是当前消息循环"
                                                    delegate:self
                                           cancelButtonTitle:@"好的" 
                                           otherButtonTitles:@"什么？", nil] autorelease];
    alert.tag = kAlertBlockType;
    [alert show];
    
    
    //起消息循环
    CFRunLoopRun();
    
    //其他地方的赋值这里可以拿到
    if (_strMsg) {
        NSLog(@"[%@]", _strMsg);
    }
    
    [_strMsg release];
    _strMsg = nil;
}

#pragma mark TextInput
- (void)showTextInputAlert
{
    _currentLoop = CFRunLoopGetCurrent();
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"你好" 
                                                     message:@"请输入新题目\n\n\n\n"
                                                    delegate:self
                                           cancelButtonTitle:@"取消" 
                                           otherButtonTitles:@"确定", nil] autorelease];
    alert.tag = kAlertTextInputType;
    [alert show];
    
    UITextField *txtField = [[UITextField alloc] initWithFrame:CGRectMake(0.0f, 
                                                                          0.0f, 
                                                                          260.0f, 
                                                                          30.0f)];
    txtField.placeholder        = @"请随便输入";
    txtField.clearButtonMode    = UITextFieldViewModeWhileEditing;
    txtField.keyboardType       = UIKeyboardTypeAlphabet;
    txtField.borderStyle        = UITextBorderStyleRoundedRect;
    txtField.center             = CGPointMake(CGRectGetWidth(alert.bounds)/2, 
                                              CGRectGetHeight(alert.bounds)/2);
    [alert addSubview:txtField];
    [txtField release];
    
    //起消息循环
    CFRunLoopRun();
    
    NSLog(@"[%@]", txtField.text);
}

#pragma mark TextInput on iOS5
- (void)showTextInputIOS5Alert
{
    UITextField *txtField   = nil;
    UIAlertView *alert      = [[[UIAlertView alloc] initWithTitle:@"你好"
                                                          message:@"我在iOS5上"
                                                         delegate:self
                                                cancelButtonTitle:@"取消" 
                                                otherButtonTitles:@"确定", nil] autorelease];
    alert.tag = kAlertTextInputType5;
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    //显示之前配置textField
    txtField = [alert textFieldAtIndex:0];
    if (txtField) {
        txtField.placeholder        = @"请随便输入";
        txtField.clearButtonMode    = UITextFieldViewModeWhileEditing;
        txtField.keyboardAppearance = UIKeyboardAppearanceDefault;
    }
    
    
    [alert show];
}

#pragma mark SecureTextInput on IOS5
- (void)showSecureTextInputIOS5Alert
{
    UITextField *txtField   = nil;
    UIAlertView *alert      = [[[UIAlertView alloc] initWithTitle:@"你好"
                                                          message:@"我在iOS5上"
                                                         delegate:self
                                                cancelButtonTitle:@"取消" 
                                                otherButtonTitles:@"确定", nil] autorelease];
    alert.tag = kAlertTextSecureInputType5;
    alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
    
    //显示之前配置textField
    txtField = [alert textFieldAtIndex:0];
    if (txtField) {
        txtField.placeholder        = @"请输入密码";
        txtField.clearButtonMode    = UITextFieldViewModeWhileEditing;
        txtField.keyboardType       = UIKeyboardTypeNumberPad;
    }
    
    
    [alert show];
}

#pragma mark login on IOS5
- (void)showLoginIOS5Alert
{
    UITextField *txtField   = nil;
    UIAlertView *alert      = [[[UIAlertView alloc] initWithTitle:@"你好"
                                                          message:@"我在iOS5上"
                                                         delegate:self
                                                cancelButtonTitle:@"取消" 
                                                otherButtonTitles:@"确定", nil] autorelease];
    alert.tag = kAlertLoginType5;
    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    
    //显示之前配置textField
    txtField = [alert textFieldAtIndex:0];
    if (txtField) {
        txtField.placeholder        = @"请输入用户名";
        txtField.clearButtonMode    = UITextFieldViewModeWhileEditing;
    }
    txtField = [alert textFieldAtIndex:1];
    if (txtField) {
        txtField.placeholder        = @"请输入密码";
        txtField.clearButtonMode    = UITextFieldViewModeWhileEditing;
    }
    
    [alert show];
}

- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView
{
    if (alertView.tag == kAlertLoginType5) {
        UITextField *textField = [alertView textFieldAtIndex:0];
        if (textField.text.length == 0) {
            return NO;
        }
    }
    
    return YES;
}

#pragma mark format alert
- (void)showFormatTypeAlert:(NSString *)format, ...
{
    NSString *strMsgContent = nil;
    
    va_list argList;
    va_start(argList, format);
    strMsgContent = [[NSString alloc] initWithFormat:format
                                           arguments:argList];
    va_end(argList);
    
    UIAlertView *alert      = [[[UIAlertView alloc] initWithTitle:@"你好"
                                                          message:strMsgContent
                                                         delegate:self
                                                cancelButtonTitle:@"取消" 
                                                otherButtonTitles:@"确定", nil] autorelease];
    [alert show];
}

#pragma mark -
#pragma mark AlertDelegation
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"按下了[%@]按钮", [alertView buttonTitleAtIndex:buttonIndex]);
    
    id tmp = nil;
    switch (alertView.tag) {
        //堵塞方式
        case kAlertBlockType:
        case kAlertTextInputType:
            _strMsg = [@"堵塞完了" retain];
            CFRunLoopStop(_currentLoop);
            break;
        //iOS5下文本框输入
        case kAlertTextInputType5:
            if (alertView.alertViewStyle != UIAlertViewStyleDefault) {
                tmp = [alertView textFieldAtIndex:0];
                if (tmp && [tmp isKindOfClass:[UITextField class]]) {
                    NSLog(@"输入框内容：[%@]", ((UITextField*)tmp).text);
                }
            }
            break;
        case kAlertTextSecureInputType5:
            if (alertView.alertViewStyle != UIAlertViewStyleDefault) {
                tmp = [alertView textFieldAtIndex:0];
                if (tmp && [tmp isKindOfClass:[UITextField class]]) {
                    NSLog(@"输入框内容：[%@]", ((UITextField*)tmp).text);
                }
            }
            break;
        case kAlertLoginType5:
            if (alertView.alertViewStyle != UIAlertViewStyleDefault) {
                tmp = [alertView textFieldAtIndex:0];
                if (tmp && [tmp isKindOfClass:[UITextField class]]) {
                    NSLog(@"用户名内容：[%@]", ((UITextField*)tmp).text);
                }
                
                tmp = [alertView textFieldAtIndex:1];
                if (tmp && [tmp isKindOfClass:[UITextField class]]) {
                    NSLog(@"密码：[%@]", ((UITextField*)tmp).text);
                }
            }
            break;
        default:
            break;
    }

}
@end
