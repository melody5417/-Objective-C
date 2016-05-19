// ################################################################################//
//		文件名 :QCMoveViewController.m
// ################################################################################//
/*!
 @file		QCMoveViewController.m
 @brief		排序功能的表视图控制器
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/12/06     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCMoveViewController.h"

@implementation QCMoveViewController
@synthesize orderItem = _orderItem, doneItem = _doneItem;

#pragma mark -
#pragma mark Init
- (void)initUI
{
    [super initUI];
    
    //导航栏右侧的排序按钮
    UIButton   *aOrderButton = [[[UIButton alloc] initWithFrame:CGRectMake(0.0f,
                                                                           0.0f,
                                                                           23.0f,
                                                                           15.0f)] autorelease];
    [aOrderButton addTarget:self action:@selector(actBeginOrder:) forControlEvents:UIControlEventTouchUpInside];
    [aOrderButton setImage:[UIImage imageNamed:@"reorder"] forState:UIControlStateNormal];
    
    _orderItem = [[UIBarButtonItem alloc] initWithCustomView:aOrderButton];
    _doneItem  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                               target:self
                                                               action:@selector(actEndOrder:)];
    
    self.navigationItem.rightBarButtonItem = _orderItem;
}

- (void)dealloc {
    [_orderItem release];
    [_doneItem release];
    [super dealloc];
}

#pragma mark -
#pragma mark Action
- (IBAction)actBeginOrder:(id)sender
{
    //进入编辑模式
    [self.tableView setEditing:YES animated:YES];
    self.navigationItem.rightBarButtonItem = _doneItem;
}

- (IBAction)actEndOrder:(id)sender
{
    //结束编辑
    [self.tableView setEditing:NO animated:YES];
    self.navigationItem.rightBarButtonItem = _orderItem;
}

#pragma mark -
#pragma mark Table view data source
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    //假设需求：教练不能移动
    if (indexPath.row == 0)
        return NO;
    
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
      toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSMutableArray  *arrNewDatasource   = [NSMutableArray arrayWithArray:self.datasource];
    RMPlayerDM      *aPlayer            = [[self.datasource objectAtIndex:sourceIndexPath.row] retain];
    
    //更新数据源
    [arrNewDatasource removeObjectAtIndex:sourceIndexPath.row];
    [arrNewDatasource insertObject:aPlayer atIndex:destinationIndexPath.row];
    [aPlayer release];
    
    [self.datasource release];
    _datasource = [[NSArray alloc] initWithArray:arrNewDatasource];
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath
       toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    //更新UI
    //拖动时，目的地位置的承认与否
    //如果不承认，可以自己制作一个有效的目的地位置NSIndexPath，返回出去
    if (proposedDestinationIndexPath.row == 0) {
        //要超过首行？不行！
        return [NSIndexPath indexPathForRow:1 inSection:proposedDestinationIndexPath.section];
    }
    
    return proposedDestinationIndexPath;
}

//每个Cell的配置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"InfoTableViewCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
	}
    
    RMPlayerDM  *onePlayer = [self.datasource objectAtIndex:indexPath.row];
    if (onePlayer) {
        cell.textLabel.text         = onePlayer.name;
        cell.textLabel.font         = [UIFont fontWithName:@"Helvetica" size:16.0f];
        cell.imageView.image        = [UIImage imageNamed:[NSString stringWithFormat:@"%@", onePlayer.number]];
        cell.detailTextLabel.text   = onePlayer.role;
        cell.detailTextLabel.font   = [UIFont fontWithName:@"Helvetica" size:12.0f];
        cell.showsReorderControl    = YES;
    }
    
	return cell;
}

#pragma mark -
#pragma mark Table view delegate
//
//下列两个代理方法，完全将“删除”/“新增”从编辑状态中隐藏走了
//
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //编辑状态不显示诸如“删除”或“新增”的图标
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    //进入编辑状态时单元行不向右缩进
    return NO;
}

@end
