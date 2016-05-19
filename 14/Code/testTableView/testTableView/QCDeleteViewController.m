// ################################################################################//
//		文件名 : QCDeleteViewController.m
// ################################################################################//
/*!
 @file		QCDeleteViewController.m
 @brief		删除功能的表视图控制器
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/12/06     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCDeleteViewController.h"

@implementation QCDeleteViewController
@synthesize editItem = _editItem, doneItem = _doneItem;

#pragma mark -
#pragma mark Init
- (void)initUI
{
    [super initUI];
    
    //开启编辑模式按钮
    _editItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                              target:self
                                                              action:@selector(actBeginEdit:)];
    //关闭编辑模式按钮
    _doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                              target:self
                                                              action:@selector(actEndEdit:)];
    
    self.navigationItem.rightBarButtonItem = _editItem;
}

- (void)dealloc
{
    [_editItem release];
    [_doneItem release];
    [super dealloc];
}

#pragma mark -
#pragma mark Action
- (IBAction)actBeginEdit:(id)sender
{
    //开启编辑模式
    [self.tableView setEditing:YES animated:YES];
    self.navigationItem.rightBarButtonItem = _doneItem;
}

- (IBAction)actEndEdit:(id)sender
{
    //关闭编辑模式
    [self.tableView setEditing:NO animated:YES];
    self.navigationItem.rightBarButtonItem = _editItem;
}

#pragma mark -
#pragma mark Table view data source
//setEditing:animated:后被调用
//询问具体的Cell是不是支持编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray  *arrNewDatasource = [NSMutableArray arrayWithArray:self.datasource];
    
    //Cell上的“Delete”按钮点击
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        if (indexPath.row >= arrNewDatasource.count) {
            return;
        }
        
        //删除
        [arrNewDatasource removeObjectAtIndex:indexPath.row];
        //更新datasource
        [_datasource release];
        _datasource = [[NSArray alloc] initWithArray:arrNewDatasource];
        
        //更新界面
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                              withRowAnimation:UITableViewRowAnimationFade];
        

    }
}

#pragma mark -
#pragma mark Table view delegate
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

//下列是两个一模一样的代理回调函数，（1）中包含了“点击删除”和“左划删除”两种删除模式
//如果想屏蔽“左划删除”的默认手势，请注释（1）而使用（2）
//
//（1）
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

//（2）
//- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (self.tableView.editing)
//    {
//        return UITableViewCellEditingStyleDelete;
//    }
//    
//    return UITableViewCellEditingStyleNone;
//}


     
@end
