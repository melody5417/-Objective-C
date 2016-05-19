// ################################################################################//
//		文件名 : RMPlayerUIDM.h
// ################################################################################//
/*!
 @file		RMPlayerUIDM.h
 @brief		real madrid球队球员Data Model
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/12/17     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Club.h"
#import "Coach.h"
#import "Player.h"

@interface RMPlayerUIDM : NSObject

@property(nonatomic, retain) NSString  *name;
@property(nonatomic, retain) NSNumber  *number;
@property(nonatomic, retain) NSString  *role;

@end

// ################################################################################//
//		文件名 : QCDBManager.h
// ################################################################################//
/*!
 @file		QCDBManager.h
 @brief		数据库管理类
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/12/17     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#define DB_NAME             @"myCoreDataDB.sqlite"
#define DB_MODELNAME		@"myModel"

@interface QCDBManager : NSObject{
	NSString						*_dbPath;
    NSFetchedResultsController      *_fetchedResultsController;
@private
	NSManagedObjectContext			*_managedObjectContext;
	NSManagedObjectModel			*_managedObjectModel;
	NSPersistentStoreCoordinator	*_persistentStoreCoordinator;
}

@property (nonatomic, retain, readonly) NSString *dbPath;
@property (nonatomic, retain) NSArray            *initContents;

- (id)initWithDBPath:(NSString*)DBPath;
- (Coach*)fetchCoach;
- (Club*)fetchClub;
- (NSFetchedResultsController*)fetchPlayers;

- (void)deletePlayer:(NSIndexPath*)aIndexPath
       withFetchedRC:(NSFetchedResultsController*)aFetchedRC;
- (void)insertPlayer:(RMPlayerUIDM*)aNewPlayer
       withFetchedRC:(NSFetchedResultsController*)aFetchedRC;
- (void)updatePlayer:(NSIndexPath*)aIndexPath
       withFetchedRC:(NSFetchedResultsController*)aFetchedRC
             newName:(NSString*)aName
            newPhoto:(UIImage*)aPhoto;


@end
