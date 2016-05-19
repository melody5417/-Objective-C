// ################################################################################//
//		文件名 : QCViewController.m
// ################################################################################//
/*!
 @file		QCViewController.m
 @brief		显示视图类
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/09/13     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "QCGetViewController.h"
#import "QCPutViewController.h"
#import "QCPostViewController.h"
#import "QCSOAPViewController.h"

@implementation QCViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //导航栏的颜色设置
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:145.0f/255.0f
                                                                        green:190.0f/255.0f
                                                                         blue:5.0f/255.0f
                                                                        alpha:1.0f];
    //导航栏的标题
    self.title = @"网络连接（URLConnection）";
}

#pragma mark -
#pragma mark UITableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
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
            strHeaderTitle = @"     模式";
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
    
    UIViewController    *vc = nil;
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                vc = [[QCGetViewController alloc] initWithNibName:@"QCGetViewController" 
                                                           bundle:nil];
                [self.navigationController pushViewController:vc animated:YES];
                [vc release];
                break;
            case 1:
                vc = [[QCPutViewController alloc] initWithNibName:@"QCPutViewController" 
                                                           bundle:nil];
                [self.navigationController pushViewController:vc animated:YES];
                [vc release];
                break;
            case 2:
                vc = [[QCPostViewController alloc] initWithNibName:@"testPostViewController" 
                                                            bundle:nil];
                [self.navigationController pushViewController:vc animated:YES];
                [vc release];
                break;
            case 3:
                vc = [[QCSOAPViewController alloc] initWithNibName:@"QCSOAPViewController" 
                                                            bundle:nil];
                [self.navigationController pushViewController:vc animated:YES];
                [vc release];
                break;
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
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
            case 0:
                strTitle = @"Get";
                break;
            case 1:
                strTitle = @"PUT";
                break;   
            case 2:
                strTitle = @"POST";
                break;    
            case 3:
                strTitle = @"SOAP";
                break;  
            default:
                strTitle = @"";
                break;
        }
    }
    
    cell.textLabel.text = strTitle;
    return cell;
    
}
@end
