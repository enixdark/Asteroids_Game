//
//  Rank.h
//  test1
//
//  Created by Cqshinn on 3/23/14.
//  Copyright (c) 2014 Cqshinn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CoreDataManager.h"

@interface Rank : NSManagedObject
{
    NSManagedObjectContext * db;
}
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * score;

-(void)insertdata:(NSString *)name score:(float)score;
-(NSArray *)fetchdatas;
//-(void)deleteEmployee:(NSManagedObject *)employee;
-(void)commitChanges;
@end
