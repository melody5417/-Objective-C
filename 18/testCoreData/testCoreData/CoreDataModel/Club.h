//
//  Club.h
//  testCoreData
//
//  Created by Jason on 17/12/12.
//  Copyright (c) 2012 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Coach, Player;

@interface Club : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Coach *coach;
@property (nonatomic, retain) Player *captain;
@property (nonatomic, retain) NSSet *players;
@end

@interface Club (CoreDataGeneratedAccessors)

- (void)addPlayersObject:(Player *)value;
- (void)removePlayersObject:(Player *)value;
- (void)addPlayers:(NSSet *)values;
- (void)removePlayers:(NSSet *)values;

@end
