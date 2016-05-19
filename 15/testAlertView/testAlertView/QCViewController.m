// ################################################################################//
//		文件名 : QCViewController.m
// ################################################################################//
/*!
 @file		QCViewController.m
 @brief		显示视图类
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/08/27     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "QCAlertUtility.h"
#import "QCSheetUtility.h"

@implementation QCViewController

#pragma mark -
#pragma mark iOS6.0 prior
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

#pragma mark -
#pragma mark iOS6.0 later
- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotate{
    return YES;
}

//主页通过表视图来创建
#pragma mark -
#pragma UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel	*labHeaderView = [[[UILabel alloc] initWithFrame:CGRectMake(0.0f, 
                                                                        0.0f,
                                                                        320, 
                                                                        40)] autorelease];
    
    NSString	*strHeaderTitle = nil;
    switch (section) {
        case 0:
            strHeaderTitle = @"     Alert";
            break;
        case 1:
            strHeaderTitle = @"     Sheet";
            break;
        default:
            strHeaderTitle = @"     ？？？";
            break;
    }
    labHeaderView.text					= strHeaderTitle;
    labHeaderView.textColor				= [UIColor darkGrayColor];
    labHeaderView.shadowColor			= [UIColor lightGrayColor];
    labHeaderView.shadowOffset			= CGSizeMake(1.0f, 1.0f);
    labHeaderView.font					= [UIFont fontWithName:@"STHeitiJ-Medium" size:15.0f];
    labHeaderView.backgroundColor		= [UIColor clearColor];
    
    return labHeaderView;
	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];

    //点击不同“警告框”效果
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case kAlertNormalType:
                [QCAlertUtility showNormalAlert];
                break;
            case kAlertUseDelegateType:
                [[QCAlertUtility defaultAlert] showDelegateAlert];
                break;
            case kAlertNoButtonType:
                [[QCAlertUtility defaultAlert] showNoButtonAlert];
                break; 
            case kAlertBlockType:
                [[QCAlertUtility defaultAlert] showBlockAlert];
                break;  
            case kAlertTextInputType:
                [[QCAlertUtility defaultAlert] showTextInputAlert];
                break;
            case kAlertTextInputType5:
                [[QCAlertUtility defaultAlert] showTextInputIOS5Alert];
                break;
            case kAlertTextSecureInputType5:
                [[QCAlertUtility defaultAlert] showSecureTextInputIOS5Alert];
                break;
            case kAlertLoginType5:
                [[QCAlertUtility defaultAlert] showLoginIOS5Alert];
                break;          
            case kAlertFormatType:
                [[QCAlertUtility defaultAlert] showFormatTypeAlert:@"亲！%@", @"我是来调戏警告框的！"];
                break;
            default:
                break;
        }
    }
    else {
        switch (indexPath.row) {
            case kSheetNormalType:
                [QCSheetUtility showNormalSheetOnView:self.view];
                break;
            case kSheetMultiType:
                [[QCSheetUtility defaultSheet] showMultiOptionOnView:self.view];
                break;       
            case kSheetProgressType:
                [[QCSheetUtility defaultSheet] showProgressOnView:self.view];
                break;
            case kSheetCustomControlType:
                [[QCSheetUtility defaultSheet] showCustomControlType:self.view];
            default:
                break;
        }
        
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{	
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return 40;
    } 
    else {
        return 50;
    }
}
#pragma mark -
#pragma UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return kAlertTypeCount;
    }
    else {
        return kSheetTypeCount;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    NSString        *strTitle   = nil;
    UITableViewCell *cell       = nil;
    
    //表视图的行创建
    cell =  (UITableViewCell*) [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                      reuseIdentifier:cellID] autorelease];
        cell.layer.cornerRadius			= 20.0f;
        cell.backgroundColor			= [UIColor whiteColor];
        cell.textLabel.font				= [UIFont fontWithName:@"STHeitiJ-Light" size:14.0f];
        cell.textLabel.numberOfLines	= 2;
    }
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case kAlertNormalType:
                strTitle = @"Alert（普通）";
                break;
            case kAlertUseDelegateType:
                strTitle = @"Alert（使用代理）";
                break;   
            case kAlertNoButtonType:
                strTitle = @"Alert（没有按钮）";
                break;    
            case kAlertBlockType:
                strTitle = @"Alert（堵塞方式）";
                break;     
            case kAlertTextInputType:
                strTitle = @"Alert（含文本输入框）";
                break;
            case kAlertTextInputType5:
                strTitle = @"Alert（iOS5实现含文本输入框）";
                break;
            case kAlertTextSecureInputType5:
                strTitle = @"Alert（iOS5实现含安全文本输入框）";
                break;
            case kAlertLoginType5:
                strTitle = @"Alert（iOS5实现登录框）";
                break;
            case kAlertFormatType:
                strTitle = @"Alert（多参数）";
                break;
            default:
                strTitle = @"未知警告框";
                break;
        }
    }
    else {
        switch (indexPath.row) {
            case kSheetNormalType:
                strTitle = @"sheet（普通）";
                break;
            case kSheetMultiType:
                strTitle = @"sheet（含多个选项）";
                break;
            case kSheetProgressType:
                strTitle = @"sheet（含进度条）";
                break;
            case kSheetCustomControlType:
                strTitle = @"sheet（含自定义控件）";
                break;
                
            default:
                strTitle = @"未知警告框";
                break;
        }
    }
    
    cell.textLabel.text = strTitle;
    return cell;
}

@end
