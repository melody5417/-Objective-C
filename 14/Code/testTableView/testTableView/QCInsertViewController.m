// ################################################################################//
//		文件名 : QCInsertViewController.m
// ################################################################################//
/*!
 @file		QCInsertViewController.m
 @brief		插入功能的表视图控制器
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/12/06     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCInsertViewController.h"

@implementation QCInsertViewController
@synthesize editItem = _editItem, doneItem = _doneItem;

#pragma mark -
#pragma mark Init
- (void)dealloc {
    [_editItem release];
    [_doneItem release];
    [super dealloc];
}

#pragma mark -
#pragma mark Table view data source
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray  *arrNewDatasource = [NSMutableArray arrayWithArray:self.datasource];
    
    //处理新增
    if (editingStyle == UITableViewCellEditingStyleInsert) {
        //新建一个RMPlayerDM对象
        RMPlayerDM  *newPlayer = [[[RMPlayerDM alloc] init] autorelease];
        newPlayer.name      = @"My Player";
        newPlayer.role      = @"GoalKeeper";
        newPlayer.number    = [NSNumber numberWithInt:_datasource.count + 10];        
        
        //插入
        [arrNewDatasource insertObject:newPlayer atIndex:indexPath.row];
        //更新datasource
        [_datasource release];
        _datasource = [[NSArray alloc] initWithArray:arrNewDatasource];
        
        //更新界面
        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                              withRowAnimation:UITableViewRowAnimationFade];        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"InfoTableViewCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
	}
    
    UIImage     *photo     = nil;
    RMPlayerDM  *onePlayer = [self.datasource objectAtIndex:indexPath.row];
    if (onePlayer) {
        cell.textLabel.text         = onePlayer.name;
        cell.textLabel.font         = [UIFont fontWithName:@"Helvetica" size:16.0f];
        cell.detailTextLabel.text   = onePlayer.role;
        cell.detailTextLabel.font   = [UIFont fontWithName:@"Helvetica" size:12.0f];
        
        //插入时，更新界面的方法insertRowsAtIndexPaths会调用cellForRowAtIndexPath询问具体的UITableViewCell
        //所以这里需要考虑为插入的元素准备的空头像图片
        photo = [UIImage imageNamed:[NSString stringWithFormat:@"%@", onePlayer.number]];
        if (!photo) {
            photo = [UIImage imageNamed:@"empty"];
        }
        cell.imageView.image        = photo;
    }
    
	return cell;
}

#pragma mark -
#pragma mark Table view delegate
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //返回新增类型
    return UITableViewCellEditingStyleInsert;
}


@end
