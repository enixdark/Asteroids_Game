#import "CoreDataManager.h"

@implementation CoreDataManager
@synthesize db, model, coordinator;


+(id)shared {
    static id shared=nil;
    if (shared == nil) {
        shared=[[self alloc] init];
    }
    return shared;
}

- (void)savedb
{
    NSError *error = nil;
    if (self.db != nil) {
        if ([db hasChanges] && ![db save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

- (NSURL *)storeDirectory {
    // applications document directory
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark -
#pragma mark Getters

- (NSManagedObjectModel *)model
{
    if (model != nil) return model;
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Data_Score" withExtension:@"momd"];
    
    model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return model;
}

- (NSPersistentStoreCoordinator *)coordinator
{
    if (coordinator != nil) return coordinator;
    
    NSURL *storeURL = [[self storeDirectory] URLByAppendingPathComponent:@"Data_Score.sqlite"];
    
    NSError *error = nil;
    coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self model]];
    
    if (![coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    return coordinator;
}

- (NSManagedObjectContext *)db
{
    if (db != nil) return db;
    
    if (self.coordinator != nil) {
        db = [[NSManagedObjectContext alloc] init];
        [db setPersistentStoreCoordinator:coordinator];
    }
    return db;
}

@end
