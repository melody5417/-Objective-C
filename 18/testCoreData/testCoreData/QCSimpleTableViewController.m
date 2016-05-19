// ################################################################################//
//		文件名 : QCSimpleTableViewController.m
// ################################################################################//
/*!
 @file		QCSimpleTableViewController.m
 @brief		表视图控制器
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/09/10     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCSimpleTableViewController.h"
#import "QCDBManager.h"
#import "QCNavigationController.h"

@implementation QCSimpleTableViewController
@synthesize fetchedResults = _fetchedResults;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initData];
    [self initUI];
}

- (void)dealloc {
    SAFE_RELEASE(_dbManager)
    SAFE_RELEASE(_selectedIndexPath)
    
    [super dealloc];
}

#pragma mark -
#pragma mark iOS6.0 prior
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

#pragma mark -
#pragma mark iOS6.0 later
- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotate {
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
    
    RMPlayerUIDM  *onePlayer = nil;
    //将信息挨个解析到数据模型中
    for (NSDictionary *onePlayerInfo in arrPlist) {
        
        onePlayer           = [[[RMPlayerUIDM alloc] init] autorelease];
        onePlayer.name      = [onePlayerInfo objectForKey:@"name"];
        onePlayer.number    = [onePlayerInfo objectForKey:@"number"];
        onePlayer.role      = [onePlayerInfo objectForKey:@"role"];
        
        [arrPlayers addObject:onePlayer];
    }

    if (!onePlayer) {
        return;
    }
    
    //将数据库放在/Documents下面
    NSString *dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask,
                                                         YES) lastObject];
    //创建DBManager对象
    _dbManager = [[QCDBManager alloc] initWithDBPath:[dir stringByAppendingPathComponent:DB_NAME]];
    _dbManager.initContents = arrPlayers;
}

- (void)initUI
{    
    //开启删除模式按钮
    _deleteItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash
                                                              target:self
                                                              action:@selector(actBeginDelete:)];
    //开启新增模式按钮
    _insertItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                target:self
                                                                action:@selector(actBeginInsert:)];
    //关闭编辑模式
    _doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                              target:self
                                                              action:@selector(actEndEdit:)];
    
    self.navigationItem.rightBarButtonItem = _deleteItem;
    self.navigationItem.leftBarButtonItem  = _insertItem;
    
    if (_dbManager) {
        Club *myClub = [_dbManager fetchClub];
        if (myClub) {
            self.title = myClub.name;
        }
    }
    
    //导航栏的颜色设置
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:145.0f/255.0f
                                                                        green:190.0f/255.0f
                                                                         blue:5.0f/255.0f
                                                                        alpha:1.0f];
}

#pragma mark -
#pragma mark Getter
-(NSFetchedResultsController  *)fetchedResults
{    
    if (_fetchedResults) {
        return _fetchedResults;
    }
    
    _fetchedResults = [[_dbManager fetchPlayers] retain];
    _fetchedResults.delegate = self;
    return _fetchedResults;
}

#pragma mark -
#pragma mark Action
- (IBAction)actBeginDelete:(id)sender
{
    //开启删除模式
    self.navigationItem.rightBarButtonItem = _doneItem;
    self.navigationItem.leftBarButtonItem  = nil;
    
    [self.tableView setEditing:YES animated:YES];
}

- (IBAction)actBeginInsert:(id)sender
{
    //开启新增模式
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.leftBarButtonItem  = _doneItem;
    
    [self.tableView setEditing:YES animated:YES];
}

- (IBAction)actEndEdit:(id)sender
{
    //关闭编辑模式
    self.navigationItem.rightBarButtonItem = _deleteItem;
    self.navigationItem.leftBarButtonItem  = _insertItem;
    
    [self.tableView setEditing:NO animated:YES];
}

#pragma mark -
#pragma mark Table view data source
//setEditing:animated:后被调用
//询问具体的Cell是不是支持编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    //教练假设是权威的存在，不能编辑
    if (indexPath.section == 0) {
        return NO;
    }
    
    return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //加上第一段Coach
    return self.fetchedResults.sections.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSFetchedResultsController中的段对象
    //他符合协议NSFetchedResultsSectionInfo
    id<NSFetchedResultsSectionInfo> sectionInfo = nil;
    
    switch (section) {
        case 0:
            //教练
            return 1;
        default:
            //将fetchedResults中对应段的行数取出来
            sectionInfo = [[self.fetchedResults sections] objectAtIndex:section - 1];
            return [sectionInfo numberOfObjects];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //NSFetchedResultsController中的段对象
    //他符合协议NSFetchedResultsSectionInfo
    id <NSFetchedResultsSectionInfo> sectionInfo = nil;
    
    switch (section) {
        case 0:
            //段名：教练
            return @"Coach";
        default:
            //将fetchedResults中对应段名取出
            sectionInfo = [[self.fetchedResults sections] objectAtIndex:section - 1];
            return [sectionInfo name];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"InfoTableViewCellID";
    //UITableView的重用机制
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
        //subtitle式样
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
	}
    
    UIImage *photo = nil;
    //教练那段
    if (indexPath.section <= 0) {
        //必要的检查
        if (indexPath.row > 1) {
            return cell;
        }
        
        //唯一的教练对象取出来
        Coach   *aCoach = (Coach*)[_dbManager fetchCoach];
        if (!aCoach) {
            return cell;
        }
        
        //对Cell进行内容配置
        cell.textLabel.text         = aCoach.name;
        cell.textLabel.font         = [UIFont fontWithName:@"Helvetica" size:16.0f];
        cell.detailTextLabel.text   = @"No:-";
        cell.detailTextLabel.font   = [UIFont fontWithName:@"Helvetica" size:12.0f];
        cell.accessoryType          = UITableViewCellAccessoryNone;
        
        //UIImageToDataTransformer起作用，成功将数据库中的属性内容转换成UIImage对象
        photo = aCoach.image;
        if (!photo) {
            photo = [UIImage imageNamed:@"empty"];
        }
        cell.imageView.image        = photo;
    }
    //球员的几段
    else
    {
        //进入专门球员Cell配置函数
        [self configureCell:cell
              atRCIndexPath:[NSIndexPath indexPathForRow:indexPath.row
                                               inSection:indexPath.section - 1]];
    }
     
	return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{    
    //删除
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        //持久层进行删除
        //界面稍后由NSFetchedResultsController的代理回到函数来完成
        //注意：界面的第一段是教练，并不属于self.fetchedResults的查询结果，所以第一个参数需要在段序号上减1。
        [_dbManager deletePlayer:[NSIndexPath indexPathForRow:indexPath.row
                                                    inSection:indexPath.section - 1]    
                   withFetchedRC:self.fetchedResults];
    }
    
    //新增
    if (editingStyle == UITableViewCellEditingStyleInsert) {        
        //新建一个RMPlayerUIDM对象
        id<NSFetchedResultsSectionInfo> sectionInfo     = nil;
        RMPlayerUIDM                    *newPlayer      = [[[RMPlayerUIDM alloc] init] autorelease];
        
        //球员名
        newPlayer.name      = @"My Player";
        
        //球员role
        //对于self.fetchedResults的section取值同样需要对section的序号减1，以跳过首段Coach
        sectionInfo = [self.fetchedResults.sections objectAtIndex:indexPath.section-1];
        newPlayer.role      = [sectionInfo name];
        
        //球员number
        if (self.fetchedResults && self.fetchedResults.fetchedObjects) {
            newPlayer.number    = [NSNumber numberWithInt:self.fetchedResults.fetchedObjects.count + 1 + 10];
        }
        else{
            newPlayer.number    = @1;
        }
        
        //持久层进行新增
        //界面稍后由NSFetchedResultsController的代理回到函数来完成
        [_dbManager insertPlayer:newPlayer withFetchedRC:self.fetchedResults];
        return;
    }
}

- (void)configureCell:(UITableViewCell *)cell atRCIndexPath:(NSIndexPath *)fetchedRCIndexPath
{
    //必要的检查
    if (!cell || !fetchedRCIndexPath) {
        return;
    }
    
    Player      *onePlayer  = nil;
    UIImage     *photo      = nil;
    
    //厉害的来咯！！！
    //NSFetchedResultsController能够像UITableView的数据源般，通过NSIndexPath取出具体的对象
    onePlayer  = (Player*)[self.fetchedResults objectAtIndexPath:fetchedRCIndexPath];
    
    //Cell内容的配置
    cell.textLabel.text         = onePlayer.name;
    cell.textLabel.font         = [UIFont fontWithName:@"Helvetica" size:16.0f];
    cell.detailTextLabel.text   = [NSString stringWithFormat:@"No:%@", [onePlayer.number stringValue]];
    cell.detailTextLabel.font   = [UIFont fontWithName:@"Helvetica" size:12.0f];
    cell.accessoryType          = UITableViewCellAccessoryDisclosureIndicator;
    
    //标明队长的些许显示不同
    if (onePlayer.captainInfo) {
        cell.accessoryType  = UITableViewCellAccessoryDetailDisclosureButton;
    }
    
    //UIImageToDataTransformer起作用，成功将数据库中的属性内容转换成UIImage对象
    photo = onePlayer.image;
    if (!photo) {
        photo = [UIImage imageNamed:@"empty"];
    }
    cell.imageView.image        = photo;
}

#pragma mark -
#pragma mark Table view delegate
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    //一编辑就缩进
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //新增模式式样
    if (self.navigationItem.rightBarButtonItem == nil) {
        return UITableViewCellEditingStyleInsert;
    }
    //删除模式式样
    else if(self.navigationItem.leftBarButtonItem == nil) {
        return UITableViewCellEditingStyleDelete;
    }
    //其他
    else {
        return UITableViewCellEditingStyleNone;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return;
    }
    //反选
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Player      *onePlayer  = nil;

    //创建编辑视图控制器
    QCDetailedViewController *detailedVC = [[[QCDetailedViewController alloc] initWithNibName:@"QCDetailedViewController"
                                                                                       bundle:nil]
                                            autorelease];
    detailedVC.delegate = self;
    QCNavigationController *aNav       = [[[QCNavigationController alloc] initWithRootViewController:detailedVC] autorelease];

    //获得具体的球员信息
    onePlayer  = (Player*)[self.fetchedResults objectAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row
                                                                                    inSection:indexPath.section - 1]];
    
    //为编辑视图控制器设置球员的初始化信息
    detailedVC.playerInfo = onePlayer;
    
    //呈现
    [self presentViewController:aNav animated:YES completion:NULL];
    
    //记录点击的具体位置
    if (_selectedIndexPath) {
        [_selectedIndexPath release];
    }
    _selectedIndexPath = [indexPath copy];
}

#pragma mark -
#pragma mark NSFetchedResultsControllerDelegate
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    //准备更新界面
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{           
    UITableView *tableView                      = self.tableView;
    NSIndexPath *aIndexPath                     = nil;
    NSIndexPath *aNewIndexPath                  = nil;
    id<NSFetchedResultsSectionInfo> sectionInfo = nil;
    
    //对于表视图的首段Coach的顾及
    aIndexPath      = [NSIndexPath indexPathForRow:indexPath.row
                                    inSection:indexPath.section+1];
    aNewIndexPath   = [NSIndexPath indexPathForRow:newIndexPath.row
                                         inSection:newIndexPath.section+1];
    switch(type) {
        case NSFetchedResultsChangeInsert:            //新增/插入
            //具体位置的段信息
            sectionInfo = [controller.sections objectAtIndex:newIndexPath.section];
            //制作具体位置，需要对段序号+1来跳过首段Coach
            aIndexPath = [NSIndexPath indexPathForRow:[sectionInfo numberOfObjects] - 1
                                            inSection:newIndexPath.section+1];
            //表视图的界面新增动作，之后会去调用新增行的Cell配置函数
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:aIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:            //删除
            //由于持久层已经同步了删除的记录，所以只需要界面删除即可
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:aIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:            //更新
            //调用Cell的配置函数，他会访问到fetchedResults中对应位置的已更新记录
            [self configureCell:[tableView cellForRowAtIndexPath:aIndexPath]
                  atRCIndexPath:indexPath];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type
{
    //段的操作
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex+1] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex+1] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    //结束更新界面
    [self.tableView endUpdates];
}

#pragma mark -
#pragma mark DetailedVC delegate
- (void)saveDetailedInfo:(QCDetailedViewController*)detailedInfoVC {
    //收起
    [self dismissViewControllerAnimated:YES completion:NULL];

    if (!_selectedIndexPath) {
        return;
    }
    
    //交给DBManager来更新持久层
    //界面的更新则等待NSFetchedResultController的代理回调函数实现
    [_dbManager updatePlayer:[NSIndexPath indexPathForRow:_selectedIndexPath.row
                                                inSection:_selectedIndexPath.section - 1]
               withFetchedRC:self.fetchedResults
                     newName:detailedInfoVC.nameTextField.text
                    newPhoto:[detailedInfoVC.photoButton imageForState:UIControlStateNormal]];
    
}

- (void)cancelDetailedInfo:(QCDetailedViewController*)detailedInfoVC {
    //收起
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
