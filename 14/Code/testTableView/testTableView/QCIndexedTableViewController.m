// ################################################################################//
//		文件名 : QCIndexedTableViewController.m
// ################################################################################//
/*!
 @file		QCIndexedTableViewController.m
 @brief		索引的表视图控制器
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/12/04     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCIndexedTableViewController.h"

@implementation QCIndexedTableViewController
#pragma mark -
#pragma mark Init
- (void)initData
{
    //承认并沿用SimpleTableView中的数据源有效性
    [super initData];
    
    //将26个字母放进_indexTitles中，
    //表示段名，也表示索引表的内容
    NSMutableArray *arrTmp = [NSMutableArray arrayWithCapacity:0];
    for(char c = 'A';c<='Z';c++) {
        [arrTmp addObject:[NSString stringWithFormat:@"%c",c]];
    }
    
    if (_indexTitles) {
        [_indexTitles release];
    }
    _indexTitles = [[NSArray alloc] initWithArray:arrTmp];
    
    //将原数据源的所有球员对象根据名字的首字母进行排序
    NSArray *sortedDatasource = [self.datasource sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        //NSArray的block排序方法，每次进行两个元素的比较
        RMPlayerDM  *player1 = obj1;
        RMPlayerDM  *player2 = obj2;
        
        //由于球员都是英文名，需要将他的姓取出
        //比如，Critiano Ronaldo名字需要取出Ronaldo这个姓
        NSString *name1 = [self getNameToSort:player1.name];
        NSString *name2 = [self getNameToSort:player2.name];
        
        //进行比较，这里的compare默认会进行首字母的比较。
        //如果相同，再进行下一个字母的比较，以此类推
        return [name1 compare:name2 options:NSCaseInsensitiveSearch];
    }];
    
    //
    //得到名字排好序的数据源后，需要将这些球员对象根据名字的首字母，进行分段
    NSMutableArray  *arrAll = [NSMutableArray arrayWithCapacity:0];
    
    //遍历26个字母
    for (NSString *aIndexTitle in _indexTitles)
    {
        arrTmp = [[NSMutableArray alloc] initWithCapacity:0];
        
        //遍历球员对象，找到那些名字是当前字母的球员，加到arrTmp中去
        for (RMPlayerDM *aPlayer in sortedDatasource) {
            NSString *aAlpha = [self getNameToSort:aPlayer.name];
            
            //不区分大小写比较
            if ([[aAlpha lowercaseString] hasPrefix:[aIndexTitle lowercaseString]]) {
                [arrTmp addObject:aPlayer];
            }
        }
        
        [arrAll addObject:arrTmp];
        [arrTmp release];
    }
    
    //重置数据源，进行赋值
    if (_datasource) {
        [_datasource release];
    }
    _datasource = [[NSArray alloc] initWithArray:arrAll];
}

//获取球员的姓
- (NSString*)getNameToSort:(NSString*)aName
{
    NSString *name  = nil;
    NSArray *arrTmp = [aName componentsSeparatedByString:@" "];
    name = (arrTmp.count > 1)? [arrTmp objectAtIndex:1]: [arrTmp objectAtIndex:0];

    return name;
}

#pragma mark -
#pragma mark Table view data source
//26个字母，代表26段
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _indexTitles.count;
}

//每段有几行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!self.datasource) {
        return 0;
    }
    
    NSArray *arrSectionPlayer = [self.datasource objectAtIndex:section];
    return arrSectionPlayer.count;
}

//索引表的内容
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _indexTitles;
}

//索引表和段之间的关联
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title
               atIndex:(NSInteger)index
{
    //告诉我们一个段名和该段的序号
    //我们需要返回一个对于索引表数组内容的序号。
    NSInteger count = 0;
    for(NSString *aAlpha in _indexTitles)
    {
        if([aAlpha isEqualToString:title]) {
            return count;
        }
        
        count ++;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"IndexTableViewCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	}
    
    //数据源有两层，需要注意获取特定球员对象的方法
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

#pragma mark -
#pragma mark Table view delegate
//段名为22px高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 22.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //使用UILabel来显示段名
    NSString    *strHeaderTitle     = @"";
    UILabel     *labHeaderView      = [[[UILabel alloc] initWithFrame:CGRectMake(0.0f,
                                                                                 0.0f,
                                                                                 320.0f,
                                                                                 22.0f)] autorelease];
    if (_indexTitles && section < _indexTitles.count) {
        strHeaderTitle = [_indexTitles objectAtIndex:section];
    }
    labHeaderView.text					= [NSString stringWithFormat:@"  %@", strHeaderTitle];
    labHeaderView.textColor				= [UIColor whiteColor];
    labHeaderView.shadowColor			= [UIColor grayColor];
    labHeaderView.shadowOffset			= CGSizeMake(1.0f, 1.0f);
    labHeaderView.font					= [UIFont fontWithName:@"Helvetica" size:16.0f];
    labHeaderView.backgroundColor		= [UIColor colorWithRed:200.0f/255.0f
                                                          green:200.0f/255.0f
                                                           blue:200.0f/255.0f
                                                          alpha:1.0f];
    
    return labHeaderView;
}

@end
