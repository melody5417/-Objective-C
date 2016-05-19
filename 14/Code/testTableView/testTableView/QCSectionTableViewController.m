// ################################################################################//
//		文件名 : QCSectionTableViewController.m
// ################################################################################//
/*!
 @file		QCSectionTableViewController.m
 @brief		分段的表视图控制器
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/12/04     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCSectionTableViewController.h"

@implementation QCSectionTableViewController
#pragma mark -
#pragma mark Init
- (void)initData
{
    //承认并沿用SimpleTableView中的数据源有效性
    [super initData];
    
    //最终的新数据源
    NSMutableArray  *arrSectionDatasource = [NSMutableArray arrayWithCapacity:0];
    //记录着当前已经使用的段名
    NSMutableArray  *arrSection           = [NSMutableArray arrayWithCapacity:0];
    //临时存放一个段名下的所有球员对象
    NSMutableArray  *arrTmp               = [NSMutableArray arrayWithCapacity:0];
    
    //对于所有球员进行遍历
    for (RMPlayerDM *onePlayer in self.datasource) {
        NSString *role = onePlayer.role;
        
        //如果当前球员的role已经被作为段名制作好，则continue
        //也意味着当前球员已经被加入到最终数据源中
        if ([arrSection containsObject:role]) {
            continue;
        }
        
        //新的role
        //再次遍历球员
        for (RMPlayerDM *rolePlayer in self.datasource) {
            //如果当前球员属于当前新的role，则加到arrTmp中
            if ([rolePlayer.role isEqualToString:role]) {
                [arrTmp addObject:rolePlayer];
            }
        }
        
        //此role被作为一个段名，制作完成
        [arrSection addObject:role];
        
        //arrTmp中包含着所有满足当前role段名的球员对象
        //加到最终的数据源中
        [arrSectionDatasource addObject:arrTmp];
        
        //重置arrTmp
        //等待新的role将所有满足的球员对象加进来。
        arrTmp = [NSMutableArray arrayWithCapacity:0];
    }
    
    //重置数据源，进行赋值
    if(_datasource){
        [_datasource release];
    }
    _datasource = [[NSArray alloc] initWithArray:arrSectionDatasource];
}

#pragma mark -
#pragma mark Table view data source
//告诉UITableView一共有分成几段
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.datasource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ((NSArray*)[self.datasource objectAtIndex:section]).count;
}

//告诉UITableView每段的段名
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
    RMPlayerDM  *onePlayer  = [((NSArray*)[self.datasource objectAtIndex:section]) objectAtIndex:0];
    return onePlayer.role;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SectionTableViewCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	}
    
    //取得每个球员的方法和SimpleTableViewController有所不同。
    //这里的数据源多了一层。
    RMPlayerDM  *onePlayer        = nil;
    NSArray     *arrSectionPlayer = [self.datasource objectAtIndex:indexPath.section];
    if (arrSectionPlayer && arrSectionPlayer.count > indexPath.row) {
        onePlayer = [arrSectionPlayer objectAtIndex:indexPath.row];
    }
    
    if (onePlayer) {
        cell.textLabel.text = onePlayer.name;
    }
    
	return cell;
}


@end
