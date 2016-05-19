// ################################################################################//
//		文件名 : QCGIndexedTableViewController.m
// ################################################################################//
/*!
 @file		QCGIndexedTableViewController.m
 @brief		Group式样的索引表视图控制器
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/12/06     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCGIndexedTableViewController.h"

@implementation QCGIndexedTableViewController
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    NSString *title = @"";
    if (_indexTitles && section < _indexTitles.count) {
        title = [_indexTitles objectAtIndex:section];
    }
    
    return [NSString stringWithFormat:@"我是[%@]的脚注", title];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString    *strHeaderTitle     = @"";
    UILabel     *labHeaderView      = [[[UILabel alloc] initWithFrame:CGRectMake(0.0f,
                                                                                 0.0f,
                                                                                 320.0f,
                                                                                 50.0f)] autorelease];
    if (_indexTitles && section < _indexTitles.count) {
        strHeaderTitle = [_indexTitles objectAtIndex:section];
    }
    labHeaderView.text					= [NSString stringWithFormat:@"  %@", strHeaderTitle];
    labHeaderView.textColor				= [UIColor whiteColor];
    labHeaderView.shadowColor			= [UIColor grayColor];
    labHeaderView.shadowOffset			= CGSizeMake(2.0f, 2.0f);
    labHeaderView.font					= [UIFont fontWithName:@"Helvetica" size:20.0f];
    labHeaderView.backgroundColor		= [UIColor clearColor];
    
    return labHeaderView;
}

@end
