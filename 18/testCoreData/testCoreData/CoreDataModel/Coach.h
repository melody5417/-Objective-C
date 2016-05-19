//
//  Coach.h
//  testCoreData
//
//  Created by Jason on 17/12/12.
//  Copyright (c) 2012 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Staff.h"

@class Club;

@interface Coach : Staff

@property (nonatomic, retain) Club *teamInfo;

@end
