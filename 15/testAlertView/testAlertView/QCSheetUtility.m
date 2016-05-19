// ################################################################################//
//		文件名 : QCSheetUtility.m
// ################################################################################//
/*!
 @file		QCSheetUtility.m
 @brief		Sheet类型的警告框
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/08/27     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCSheetUtility.h"

QCSheetUtility *_gSheetInstance = nil;
@implementation QCSheetUtility

+ (id)defaultSheet
{
    if (_gSheetInstance == nil) {
        _gSheetInstance = [[QCSheetUtility alloc] init];
    }
    
    return _gSheetInstance;
}

#pragma mark -
#pragma mark Normal
+ (void)showNormalSheetOnView:(UIView*)aView
{
    if (!aView) {
        return;
    }
    
    //destructiveButton的颜色和其他按钮不同，呈现红色
    //表示用户需要注意，一般用于不可逆操作等。
    UIActionSheet   *sheet = [[UIActionSheet alloc] initWithTitle:@"你好"
                                                         delegate:nil
                                                cancelButtonTitle:@"确定"
                                           destructiveButtonTitle:@"此项需要用户注意"
                                                otherButtonTitles:nil];
    [sheet showInView:aView];
}

#pragma mark -
#pragma mark Multi
- (void)showMultiOptionOnView:(UIView*)aView
{
    if (!aView) {
        return;
    }
    
    //sheet最多提供7个选项时，可以全部看到
    //超过7个，otherButton的选项会以滚动条来显示
    UIActionSheet   *sheet = [[UIActionSheet alloc] initWithTitle:@"你好"
                                                         delegate:self
                                                cancelButtonTitle:@"确定"
                                           destructiveButtonTitle:@"此项需要用户注意"
                                                otherButtonTitles:@"其他选项A", @"其他选项B", @"其他选项C",@"其他选项D",@"其他选项E",@"其他选项F", nil];
    [sheet showInView:aView]; 
}

#pragma mark Progress
- (void)showProgressOnView:(UIView*)aView
{
    if (!aView) {
        return;
    }
    
    //Sheet创建
    UIActionSheet   *sheet = [[[UIActionSheet alloc] initWithTitle:@"这是进度条\n\n\n"
                                                         delegate:nil
                                                cancelButtonTitle:nil
                                           destructiveButtonTitle:nil
                                                otherButtonTitles:nil] autorelease];
    
    //进度条创建
    UIProgressView *progress = [[UIProgressView alloc] initWithFrame:CGRectMake(0.0f,
                                                                                40.0f,
                                                                                220.0f,
                                                                                90.0f)];
    //进度条配置
    progress.progressViewStyle = UIProgressViewStyleDefault;
    progress.progress = 0.0f;
    [sheet addSubview:progress];
    [progress release];
    
    //起一个定时器，来更新进度条
    [NSTimer scheduledTimerWithTimeInterval:0.03f
                                     target:self
                                   selector:@selector(updateProgress:) 
                                   userInfo:[NSDictionary dictionaryWithObjects:
                                             [NSArray arrayWithObjects:progress, sheet, nil]
                                                                        forKeys:
                                             [NSArray arrayWithObjects:@"progress", @"sheet", nil]] 
                                    repeats:YES];
     
    [sheet showInView:aView];
    progress.center = CGPointMake(CGRectGetWidth(sheet.bounds)/2,
                                  CGRectGetHeight(sheet.bounds)/2);
}

- (void)updateProgress:(NSTimer*)aTimer
{
    UIProgressView  *progress = nil;
    UIActionSheet   *sheet    = nil;
    //将定时器中，有用的内容取出来
    NSDictionary    *dictInfo = aTimer.userInfo;
    if (!dictInfo) {
        return;
    }
    
    progress = [dictInfo objectForKey:@"progress"];
    if (!progress) {
        return;
    }
    
    //进度条满了
    if (progress.progress >= 1.0f) {
        sheet = [dictInfo objectForKey:@"sheet"];
        //将sheet关闭
        if (sheet) {
            [sheet dismissWithClickedButtonIndex:0
                                        animated:YES];
        }
        
        //定时器销毁
        [aTimer invalidate];
    }
    else {
        //进度条的速度
        progress.progress += 0.01f;
    }
}

#pragma mark CustomControl
- (void)showCustomControlType:(UIView*)aView
{
    //创建sheet，为picker腾出空间
    UIActionSheet   *sheet = [[UIActionSheet alloc] initWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n"
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"确定", nil];
    sheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	
    UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0.0f, 
                                                                          0.0f,
                                                                          CGRectGetWidth(sheet.frame),
                                                                          216.0f)];
    picker.delegate = self;
    picker.dataSource = self;
    picker.showsSelectionIndicator = YES;
    
    [sheet addSubview:picker];
	
    [sheet showInView:aView];
}

- (NSString *)pickerView:(UIPickerView *)pickerView 
             titleForRow:(NSInteger)row 
            forComponent:(NSInteger)component
{
    switch (row) {
        case 0:
            return @"上海";
            break;
        case 1:
            return @"北京";
            break;
        case 2:
            return @"深圳";
            break;
        case 3:
            return @"香港";
            break;
        case 4:
            return @"台湾";
            break;
        default:
            return @"上海";
            break;
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 5;
}


#pragma mark -
#pragma mark SheetDelegation
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"按下了[%@]按钮", [actionSheet buttonTitleAtIndex:buttonIndex]);
}

@end
