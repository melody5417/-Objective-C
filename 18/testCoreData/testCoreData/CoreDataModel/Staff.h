//
//  Staff.h
//  testCoreData
//
//  Created by Jason on 17/12/12.
//  Copyright (c) 2012 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Staff : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * role;
@property (nonatomic, retain) UIImage  * image;

@end
