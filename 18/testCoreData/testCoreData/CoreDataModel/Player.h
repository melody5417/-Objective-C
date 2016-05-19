//
//  Player.h
//  testCoreData
//
//  Created by Jason on 17/12/12.
//  Copyright (c) 2012 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Staff.h"

@class Club;

@interface Player : Staff

@property (nonatomic, retain) NSNumber * number;
@property (nonatomic, retain) Club *captainInfo;
@property (nonatomic, retain) Club *playerInfo;

@end
