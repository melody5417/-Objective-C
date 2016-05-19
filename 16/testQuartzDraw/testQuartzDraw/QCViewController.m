// ################################################################################//
//		文件名 : QCViewController.m
// ################################################################################//
/*!
 @file		QCViewController.m
 @brief		显示视图类
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/10/01     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "QCDrawGraphViewController.h"
#import "QCDrawFreeViewController.h"


@implementation QCViewController {
    QCDrawGraphViewController *drawGraphVC;
    QCDrawFreeViewController  *drawFreeVC;
}

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
            strHeaderTitle = @"     画图形";
            break;
        case 1:
            strHeaderTitle = @"     随意画";
            break;
        default:
            strHeaderTitle = @"     ？？？";
            break;
    }
    labHeaderView.text					= strHeaderTitle;
    labHeaderView.textColor				= [UIColor whiteColor];
    labHeaderView.shadowColor			= [UIColor blackColor];
    labHeaderView.shadowOffset			= CGSizeMake(1.0f, 1.0f);
    labHeaderView.font					= [UIFont fontWithName:@"STHeitiJ-Medium" size:15.0f];
    labHeaderView.backgroundColor		= [UIColor clearColor];
    
    return labHeaderView;
	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                if (!drawGraphVC) {
                    drawGraphVC = [[QCDrawGraphViewController alloc] initWithNibName:@"QCDrawGraphViewController" 
                                                                            bundle:nil];
                }
                
                [self presentViewController:drawGraphVC
                                   animated:YES
                                 completion:^{
                                     
                                 }];
                break;
            default:
                break;
        }
    }
    else {
        switch (indexPath.row) {
            case 0:
                if (!drawFreeVC) {
                    drawFreeVC = [[QCDrawFreeViewController alloc] initWithNibName:@"QCDrawFreeViewController" 
                                                                          bundle:nil];
                }
                
                [self presentViewController:drawFreeVC
                                   animated:YES
                                 completion:^{
                                     
                                 }];
                break;
            default:
                break;
        }
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{	
    return 40;
}
#pragma mark -
#pragma UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    NSString        *strTitle   = nil;
    UITableViewCell *cell       = nil;
    
    
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
            default:
                strTitle = @"开始画固定图形咯！";
                break;
        }
    }
    else {
        switch (indexPath.row) {
            default:
                strTitle = @"开始随便画画咯！";
                break;
        }
    }
    
    cell.textLabel.text = strTitle;
    return cell;
    
}

@end
