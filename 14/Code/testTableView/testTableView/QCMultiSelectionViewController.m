// ################################################################################//
//		文件名 :QCMultiSelectionViewController.m
// ################################################################################//
/*!
 @file		QCMultiSelectionViewController.m
 @brief		多选功能的表视图控制器
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/12/06     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCMultiSelectionViewController.h"
#import "QCMultiSelectionCell.h"

@implementation QCMultiSelectionViewController
- (void)initUI
{
    [super initUI];
    
    //为了多选
    self.tableView.allowsSelection              = YES;
    self.tableView.allowsSelectionDuringEditing = YES;
}


#pragma mark -
#pragma mark Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MultiTableViewCellID";
    QCMultiSelectionCell *cell = (QCMultiSelectionCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[QCMultiSelectionCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier]
                autorelease];
	}
    
    RMPlayerDM  *onePlayer = [self.datasource objectAtIndex:indexPath.row];
    if (onePlayer) {
        cell.textLabel.text         = onePlayer.name;
        cell.textLabel.font         = [UIFont fontWithName:@"Helvetica" size:16.0f];
        cell.imageView.image        = [UIImage imageNamed:[NSString stringWithFormat:@"%@", onePlayer.number]];
        cell.detailTextLabel.text   = onePlayer.role;
        cell.detailTextLabel.font   = [UIFont fontWithName:@"Helvetica" size:12.0f];
    
        //进入编辑状态时，由于要多选，所以选择好的cell的背景颜色需要和未选择的cell背景颜色有区别
        //所以这里cell上的元素需要背景设置成透明(默认白色)，以不影响cell选中状态时背景颜色的显示效果
        cell.textLabel.backgroundColor          = [UIColor clearColor];
        cell.detailTextLabel.backgroundColor    = [UIColor clearColor];
    }
    
	return cell;
}

#pragma mark -
#pragma mark Table view delegate
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //不要显示任何编辑的图标
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    //编辑中状态的cell选择
	if (self.tableView.editing)
	{
        if (!self.datasource || indexPath.section >= self.datasource.count) {
            return;
        }
        
        //更新cell的选择状态
		QCMultiSelectionCell *cell = (QCMultiSelectionCell*)[tableView cellForRowAtIndexPath:indexPath];
        cell.checked = !cell.checked;
		[cell setChecked:cell.checked];
	}
    
}

@end
