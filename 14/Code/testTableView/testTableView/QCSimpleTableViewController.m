// ################################################################################//
//		文件名 : RMPlayerDM.m
// ################################################################################//
/*!
 @file		RMPlayerDM.m
 @brief		Real Madrid球队球员的Data Model
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/12/04     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCSimpleTableViewController.h"

@implementation RMPlayerDM
@synthesize name = _name;
@synthesize number = _number;
@synthesize role = _role;

- (void)dealloc
{
    [_name release];
    [_number release];
    [_role release];
    
    [super dealloc];
}

@end

// ################################################################################//
//		文件名 : QCSimpleTableViewController.m
// ################################################################################//
/*!
 @file		QCSimpleTableViewController.m
 @brief		最基本最简单的表视图控制器
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/12/04     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
@implementation QCSimpleTableViewController
@synthesize datasource = _datasource;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        //初始化球员数据
        [self initData];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //初始化界面
    [self initUI];
}

- (void)dealloc
{
    [_datasource release];
    [super dealloc];
}

#pragma mark -
#pragma mark Rotation
#pragma mark -iOS6.0 prior
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark -
#pragma mark -iOS6.0 later
- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

#pragma mark -
#pragma mark Init
- (void)initData
{
    NSMutableArray  *arrPlayers = [NSMutableArray arrayWithCapacity:0];
    NSArray         *arrPlist   = nil;
    
    //读取工程中的球员信息plist
    arrPlist = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"rmroll"
                                                                                ofType:@"plist"]];
    
    RMPlayerDM  *onePlayer = nil;
    //将信息挨个解析到数据模型中
    for (NSDictionary *onePlayerInfo in arrPlist) {
        
        onePlayer           = [[[RMPlayerDM alloc] init] autorelease];
        onePlayer.name      = [onePlayerInfo objectForKey:@"name"];
        onePlayer.number    = [onePlayerInfo objectForKey:@"number"];
        onePlayer.role      = [onePlayerInfo objectForKey:@"role"];
        
        [arrPlayers addObject:onePlayer];
    }
    
    //数据源的赋值
    if (_datasource != nil) {
        [_datasource release];
    }
    _datasource = [[NSArray alloc] initWithArray:arrPlayers];
}

- (void)initUI
{
    self.tableView.allowsSelection = NO;
    self.tableView.backgroundColor = [UIColor whiteColor];
}

#pragma mark -
#pragma mark Getter
- (NSString*)title {
    return @"皇家马德里";
}

#pragma mark -
#pragma mark Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //告诉UITableView，一共有几行
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SimpleTableViewCellID";
    
    //UITableViewCell的重用机制
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]
                autorelease];
	}

    //配置Cell的内容
    RMPlayerDM  *onePlayer = [self.datasource objectAtIndex:indexPath.row];
    if (onePlayer) {
        cell.textLabel.text = onePlayer.name;
    }
        
    //提供UITableView需要的Cell
	return cell;
}

@end
