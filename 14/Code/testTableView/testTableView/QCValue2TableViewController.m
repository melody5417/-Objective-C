// ################################################################################//
//		文件名 : QCValue2TableViewController.m
// ################################################################################//
/*!
 @file		QCValue2TableViewController.m
 @brief		value2式样的表视图控制器
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/12/05     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCValue2TableViewController.h"

@implementation QCValue2TableViewController

#pragma mark -
#pragma mark Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"value2TableViewCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
        //UITableViewCellStyleValue1式样
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
	}
    
    RMPlayerDM  *onePlayer = [self.datasource objectAtIndex:indexPath.row];
    if (onePlayer) {
        //主要内容
        cell.textLabel.text         = onePlayer.role;
        cell.textLabel.font         = [UIFont fontWithName:@"Helvetica" size:12.0f];
        //value2式样不允许有图片
//        cell.imageView.image        = [UIImage imageNamed:[NSString stringWithFormat:@"%@", onePlayer.number]];
        //辅助内容
        cell.detailTextLabel.text   = onePlayer.name;
        cell.detailTextLabel.font   = [UIFont fontWithName:@"Helvetica" size:16.0f];
    }
    
	return cell;
}

@end
