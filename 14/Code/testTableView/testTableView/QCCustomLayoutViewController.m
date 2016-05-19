// ################################################################################//
//		文件名 : QCCustomLayoutViewController.m
// ################################################################################//
/*!
 @file		QCCustomLayoutViewController.m
 @brief		自定义式样的表视图控制器
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/12/05     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCCustomLayoutViewController.h"
#import "QCCustomCell.h"

@implementation QCCustomLayoutViewController
#define PLAYERNO_TAG 1
#define PLAYERNAME_TAG 2
#define PLAYERROLE_TAG 3
#define PLAYERPHOTO_TAG 4

#pragma mark -
#pragma mark Init
- (void)initUI
{
    [super initUI];
    
    //表单元可点击
    self.tableView.allowsSelection  = YES;
    //表单元高度
    self.tableView.rowHeight        = 60.0f;
}

#pragma mark -
#pragma mark Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    static NSString *CellIdentifier = @"customTableViewCellID";
    
    QCCustomCell *cell = (QCCustomCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
        //读取xib中的内容
        NSArray *arrNib = [[NSBundle mainBundle] loadNibNamed:@"QCCustomCell"
                                                        owner:self
                                                      options:nil];
        if (arrNib) {
            //第一个元素就是需要的UITableViewCell
            cell =  (QCCustomCell*)[arrNib objectAtIndex:0];
        }
	}
    
    //配置UITableViewCell
    RMPlayerDM  *onePlayer = [self.datasource objectAtIndex:indexPath.row];
    if (onePlayer) {
        cell.playerName.text        = onePlayer.name;
        cell.playerRole.text        = onePlayer.role;
        cell.playerNumber.text      = [NSString stringWithFormat:@"No.%@", onePlayer.number];
        cell.playerPhoto.image      = [UIImage imageNamed:[NSString stringWithFormat:@"%@", onePlayer.number]];
    }
    
	return cell;
}

#pragma mark -
#pragma mark Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //反选
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //做些响应的事情
    RMPlayerDM  *onePlayer = [self.datasource objectAtIndex:indexPath.row];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"嗨！"
                                                    message:[NSString stringWithFormat:@"我是“%@”", onePlayer.name]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}

//蓝色右箭头的点击事件
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    [self tableView:tableView didSelectRowAtIndexPath:indexPath];
}

@end
