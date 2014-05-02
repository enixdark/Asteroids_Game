#import "cocos2d.h"
#import <CoreData/CoreData.h>

@interface CoreDataManager : NSObject 
{
    
}
@property (nonatomic, retain, readonly) NSManagedObjectContext *db;
@property (nonatomic, retain, readonly) NSManagedObjectModel *model;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *coordinator;

+(id)shared;

-(void)savedb; // save context into store
-(NSURL *)storeDirectory; // url to store
@end
