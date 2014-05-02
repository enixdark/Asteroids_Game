//
//  Rank.m
//  test1
//
//  Created by Cqshinn on 3/23/14.
//  Copyright (c) 2014 Cqshinn. All rights reserved.
//

#import "Rank.h"


@implementation Rank

@dynamic name;
@dynamic score;

#pragma mark -
#pragma mark Store

-(void)commitChanges {
    [[CoreDataManager shared] savedb];
}

#pragma mark -
#pragma mark Employees

-(void)insertdata:(NSString *)name score:(float)score{
    // Insert employee in context
    NSManagedObject *employee = [NSEntityDescription insertNewObjectForEntityForName:@"Data_Score" inManagedObjectContext:db];
    // set employee atributes
    [employee setValue:name forKey:@"name"];
    [employee setValue:[NSNumber numberWithInt:score] forKey:@"score"];
}

//-(void)deleteEmployee:(NSManagedObject *)employee {
//    [db deleteObject:employee];
//}

-(NSArray *)fetchdatas {
    
    // construct a fetch request
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Data_Score" inManagedObjectContext:db];
    [fetchRequest setEntity:entity];
    [fetchRequest autorelease];
    
    // return the result of executing the fetch request
    return [db executeFetchRequest:fetchRequest error:&error];
}

#pragma mark -
#pragma mark Initialization

-(void)printPathToStore {
    NSLog(@"%@",[[CoreDataManager shared] storeDirectory].path);
}

-(id)init {
    if ((self = [super init])) {
        db = [[CoreDataManager shared] db];
        [self printPathToStore];
    }
    return self;
}

-(void)dealloc
{
	[super dealloc];
}

@end
