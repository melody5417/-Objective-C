// ################################################################################//
//		文件名 : QCInfoViewController.m
// ################################################################################//
/*!
 @file		QCInfoViewController.m
 @brief		带信息的表视图控制器
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/12/04     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCInfoViewController.h"
#import <QuartzCore/QuartzCore.h>
@implementation QCInfoViewController

#pragma mark -
#pragma mark Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"InfoTableViewCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
        //subtitle式样
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier]
                autorelease];
        cell.clipsToBounds = YES;
	}
    
    RMPlayerDM  *onePlayer = [self.datasource objectAtIndex:indexPath.row];
    if (onePlayer) {
        //主要内容
        cell.textLabel.text         = onePlayer.name;
        cell.textLabel.font         = [UIFont fontWithName:@"Helvetica" size:16.0f];
        //图片
        cell.imageView.image        = [UIImage imageNamed:[NSString stringWithFormat:@"%@", onePlayer.number]];
        //辅助内容
        cell.detailTextLabel.text   = onePlayer.role;
        cell.detailTextLabel.font   = [UIFont fontWithName:@"Helvetica" size:12.0f];
    }
    
	return cell;
}

@end
