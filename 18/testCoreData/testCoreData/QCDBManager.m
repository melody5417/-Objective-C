// ################################################################################//
//		文件名 : RMPlayerUIDM.m
// ################################################################################//
/*!
 @file		RMPlayerUIDM.m
 @brief		real madrid球队球员Data Model
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/12/17     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCDBManager.h"

@implementation RMPlayerUIDM
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
//		文件名 : QCDBManager.m
// ################################################################################//
/*!
 @file		QCDBManager.m
 @brief		数据库管理类
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/09/10     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
@implementation QCDBManager
@synthesize dbPath = _dbPath;
@synthesize initContents;

- (id)initWithDBPath:(NSString*)DBPath
{
    self = [super init];
	if (self != nil) {
        if (DBPath) {
            _dbPath = [[NSString alloc] initWithString:DBPath];
        }
	}
	
	return self;
}

- (void)dealloc
{
    if (_dbPath) {
        [_dbPath release];
        _dbPath = nil;
    }
    
    [super dealloc];
}

#pragma mark -
#pragma mark Utility
- (void)initDBContents:(NSManagedObjectContext *)context
{
    if (!self.initContents) {
        return;
    }
    
    //Club的表
    NSEntityDescription	*clubEntity = [NSEntityDescription entityForName:@"Club"
                                                  inManagedObjectContext:context];
    //插入一个球队对象
    Club *aClub = [NSEntityDescription insertNewObjectForEntityForName:[clubEntity name]
                                                inManagedObjectContext:context];
    //Club对象的属性设置
    aClub.name = @"皇家马德里";
    
    //Player的表
    NSEntityDescription *playerEntity   = [NSEntityDescription entityForName:@"Player"
                                                      inManagedObjectContext:context];
    Player              *onePlayer      = nil;
    //Coach的表
    NSEntityDescription *coachEntity    = [NSEntityDescription entityForName:@"Coach"
                                                      inManagedObjectContext:context];
    Coach               *oneCoach       = nil;
    UIImage             *aPhoto         = nil;
    for (RMPlayerUIDM *plistPlayer in self.initContents)
    {
        //根据rmroll.plist中的Role内容进行比较
        if (plistPlayer.role && ![plistPlayer.role isEqualToString:@"Coach"]) {
            //
            //球员
            //
            //插入一个球员对象
            onePlayer = [NSEntityDescription insertNewObjectForEntityForName:[playerEntity name]
                                                      inManagedObjectContext:context];
            //球员对象的属性设置
            onePlayer.number = plistPlayer.number;
            onePlayer.name   = plistPlayer.name;
            onePlayer.role   = plistPlayer.role;
            
            aPhoto = [UIImage imageNamed:[NSString stringWithFormat:@"%@", plistPlayer.number]];
            if (!aPhoto) {
                aPhoto = [UIImage imageNamed:@"empty"];
            }
            onePlayer.image   = aPhoto;
            
            //设置球队表和球员表的关系
            [aClub addPlayersObject:onePlayer];
        }
        else if (plistPlayer.role && [plistPlayer.role isEqualToString:@"Coach"]) {
            //
            //教练
            //
            //插入一个教练对象
            oneCoach = [NSEntityDescription insertNewObjectForEntityForName:[coachEntity name]
                                                     inManagedObjectContext:context];
            //教练对象的属性设置
            oneCoach.name   = plistPlayer.name;
            oneCoach.role   = plistPlayer.role;
            
            aPhoto = [UIImage imageNamed:[NSString stringWithFormat:@"%@", plistPlayer.number]];
            if (!aPhoto) {
                aPhoto = [UIImage imageNamed:@"empty"];
            }
            oneCoach.image   = aPhoto;
            
            //设置球队表和教练表的关系
            aClub.coach = oneCoach;
            continue;
        }
        
        //另外，如果是号码为1的球员，则任命为队长
        if (onePlayer.name && [onePlayer.number isEqualToNumber:@1]) {
            aClub.captain = onePlayer;
        }
    }
    
    //保存到持久层
    NSError *error = nil;
	if (![context save:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
	}
}

#pragma mark -
#pragma mark Core Data stack
- (NSManagedObjectContext *)managedObjectContext
{
    //已经生成了立即返回
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
	
    //通过NSPersistentStoreCoordinator对象生成新的NSManagedObjectContext对象
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [NSManagedObjectContext new];
        [_managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    
    //创建失败
    if (!_managedObjectContext) {
        return nil;
    }
    
    //确保数据库中做过内容的初始化
    id hasInit = [[NSUserDefaults standardUserDefaults] objectForKey:@"initFinished"];
    if (!hasInit ||
        ([hasInit isKindOfClass:[NSNumber class]] && ![(NSNumber*)hasInit boolValue]))
    {
        [self initDBContents:_managedObjectContext];
        [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:@"initFinished"];
    }
    
    return _managedObjectContext;
}


- (NSManagedObjectModel *)managedObjectModel
{
    //已经生成了立即返回
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
	
    //数据模型路径
	NSString *modelPath		= [[NSBundle mainBundle] pathForResource:DB_MODELNAME
                                                              ofType:@"momd"];
    if (modelPath) {
        //通过"数据模型路径"对象生成新的NSManagedObjectModel对象
		_managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:
                                [NSURL fileURLWithPath:modelPath]];
    }
	
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    //已经生成了立即返回
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    //持久化文件的路径检查
    if (!_dbPath) {
		NSLog(@"No DB Path");
        return nil;
    }
	
	NSError			*error			= nil;
	NSURL			*storeURL		= nil;
	
    //通过"数据模型路径"对象生成新的NSManagedObjectModel对象
	_persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:
                                    [self managedObjectModel]];
	if (_persistentStoreCoordinator == nil) {
		return nil;
	}
    
    //在本地文件系统中生成持久化文件
	storeURL = [NSURL fileURLWithPath:_dbPath];
	if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                    configuration:nil
                                                              URL:storeURL
                                                          options:nil
                                                            error:&error]) 
	{
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
	
	return _persistentStoreCoordinator;
}

#pragma mark -
#pragma mark Fetch
- (Coach*)fetchCoach
{
	NSManagedObjectContext	*context			=	nil;
	NSEntityDescription		*coachEntity		=	nil;
    //最关键的变量，查询请求对象
	NSFetchRequest			*fetchRequest		=	[[NSFetchRequest alloc] init];
	NSSortDescriptor		*sortDescriptor		=	nil;
	NSArray					*arrCoachList		=	nil;
	NSError					*error				=	nil;
	
    //确保Context存在
	context	= [self managedObjectContext];
	if (context == nil) {
		[fetchRequest release];
		return nil;
	}
	
    //获得表对象
	coachEntity	= [NSEntityDescription entityForName:@"Coach"
                                inManagedObjectContext:context];
    //查询对象有了具体的表名，现在它知道去哪张表进行查询
	[fetchRequest setEntity:coachEntity];
	
    //排序规则
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name"
												 ascending:YES];
    //查询对象知道了对查询结果进行以name属性的内容为依据的排序
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
	[sortDescriptor release];
	
    //对Context进行查询
    //CoreData中Context代表着操作的介质，做任何操作需要同步到持久层的话都需要对Context进行调用
	arrCoachList = [context executeFetchRequest:fetchRequest error:&error];
    [fetchRequest release];
    
    if (arrCoachList && arrCoachList.count > 0) {
        return (Coach*)[arrCoachList objectAtIndex:0];
    }
    
    return nil;
}

- (Club*)fetchClub
{
    NSManagedObjectContext	*context			=	nil;
	NSEntityDescription		*clubEntity         =	nil;
    //最关键的变量，查询请求对象
	NSFetchRequest			*fetchRequest		=	[[NSFetchRequest alloc] init];
	NSSortDescriptor		*sortDescriptor		=	nil;
	NSArray					*arrClubList		=	nil;
	NSError					*error				=	nil;
	
    //确保Context存在
	context	= [self managedObjectContext];
	if (context == nil) {
		[fetchRequest release];
		return nil;
	}
	
    //获得表对象
	clubEntity	= [NSEntityDescription entityForName:@"Club"
                                inManagedObjectContext:context];
    //查询对象有了具体的表名，现在它知道去哪张表进行查询
	[fetchRequest setEntity:clubEntity];
	
    //排序规则
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name"
												 ascending:YES];
    //查询对象知道了对查询结果进行以name属性的内容为依据的排序
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
	[sortDescriptor release];
	
    //对Context进行查询
    //CoreData中Context代表着操作的介质，做任何操作需要同步到持久层的话都需要对Context进行调用
	arrClubList = [context executeFetchRequest:fetchRequest error:&error];
    [fetchRequest release];

    //返回的是一个数组，记录着所有符合查询条件的查询结果
    if (arrClubList && arrClubList.count > 0) {
        return (Club*)[arrClubList objectAtIndex:0];
    }
    
    return nil;
}

- (NSFetchedResultsController*)fetchPlayers
{
    NSManagedObjectContext	*context			=	nil;
	NSEntityDescription		*playerEntity       =	nil;
	NSFetchRequest			*fetchRequest		=	[[NSFetchRequest alloc] init];
	NSError					*error				=	nil;
	
    //确保Context存在
	context	= [self managedObjectContext];
	if (context == nil) {
		[fetchRequest release];
		return nil;
	}
	
    //获得表对象
	playerEntity = [NSEntityDescription entityForName:@"Player"
                               inManagedObjectContext:context];
    //查询对象有了具体的表名，现在它知道去哪张表进行查询
	[fetchRequest setEntity:playerEntity];
	
    //排序规则，先是role排序，随后是号码排序
    NSSortDescriptor *roleDescriptor = [[NSSortDescriptor alloc] initWithKey:@"role" ascending:YES];
    NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"number" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:roleDescriptor, nameDescriptor, nil]];
	[roleDescriptor release];
	[nameDescriptor release];
    
//    //number小于5并且名字以I字母开头
//    NSPredicate  *pr = [NSPredicate predicateWithFormat:@"number < 5 AND name like %@", @"I*"];
//	[fetchRequest setPredicate:pr];
    
    //关键的NSFetchedResultsController对象创建
    if (!_fetchedResultsController) {
        _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest   //查询条件
                                                                        managedObjectContext:context        //查询介质
                                                                          sectionNameKeyPath:@"role"        //以属性role作为分段的依据
                                                                                   cacheName:@"players"];   //查询的缓存名
    }
    else{
        //删除缓存，准备重新进行查询
        [NSFetchedResultsController deleteCacheWithName:@"players"];
    }
    
    [fetchRequest release];
    //正式查询，结果交给NSFetchedResultsController对象
    if ([_fetchedResultsController performFetch:&error] && !error) {
        return _fetchedResultsController;
    }
    else{
        return nil;
    }
}

- (void)deletePlayer:(NSIndexPath*)aIndexPath
       withFetchedRC:(NSFetchedResultsController*)aFetchedRC
{
    if (!aIndexPath || !aFetchedRC) {
        return;
    }
    
    NSManagedObjectContext *context = [aFetchedRC managedObjectContext];
    
    //找到记录，进行删除
    [context deleteObject:[aFetchedRC objectAtIndexPath:aIndexPath]];
    
    NSError *error;
    //将删除的动作同步到持久层
    if (![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

- (void)insertPlayer:(RMPlayerUIDM*)aNewPlayer
       withFetchedRC:(NSFetchedResultsController*)aFetchedRC
{
    if (!aNewPlayer || !aFetchedRC) {
        return;
    }
    
    NSManagedObjectContext  *context        = aFetchedRC.managedObjectContext;
    NSEntityDescription     *playerEntity   = [NSEntityDescription entityForName:@"Player"
                                                      inManagedObjectContext:context];
    Player                  *onePlayer      = nil;
    Club                    *aClub          = [self fetchClub];
    UIImage                 *aPhoto         = nil;
    
    //新增一条记录
    onePlayer = [NSEntityDescription insertNewObjectForEntityForName:[playerEntity name]
                                              inManagedObjectContext:context];
    //将RMPlayerUIDM转换成CoreData需要的Player对象
    onePlayer.number = aNewPlayer.number;
    onePlayer.name   = aNewPlayer.name;
    onePlayer.role   = aNewPlayer.role;
    aPhoto = [UIImage imageNamed:[NSString stringWithFormat:@"%@", aNewPlayer.number]];
    if (!aPhoto) {
        aPhoto = [UIImage imageNamed:@"empty"];
    }
    onePlayer.image   = aPhoto;
    
    //关系不要忘记设置
    [aClub addPlayersObject:onePlayer];
    
    NSError *error;
    //将新增的动作同步到持久层
    if (![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

- (void)updatePlayer:(NSIndexPath*)aIndexPath
       withFetchedRC:(NSFetchedResultsController*)aFetchedRC
             newName:(NSString*)aName
            newPhoto:(UIImage*)aPhoto
{
    if (!aIndexPath || !aFetchedRC) {
        return;
    }
    
    //将具体的记录取出来进行更新
    Player  *onePlayer = [aFetchedRC objectAtIndexPath:aIndexPath];
    onePlayer.name  = aName;
    onePlayer.image = aPhoto;
        
    NSError *error;
    //保存
    if (![[aFetchedRC managedObjectContext] save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

@end
