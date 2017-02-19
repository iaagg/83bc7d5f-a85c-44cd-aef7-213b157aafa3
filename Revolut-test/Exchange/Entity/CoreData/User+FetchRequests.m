
#import "User+FetchRequests.h"
#import "User+CoreDataProperties.h"

@implementation User (FetchRequests)

+ (User *)findByName:(NSString *)name inContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [self fetchRequest];
    NSPredicate *namePredicate = [NSPredicate predicateWithFormat:@"username = %@", name];
    [request setPredicate:namePredicate];
    NSArray *results = [self p_executeFetchRequest:request inContext:context];
    
    if (results) {
        return (User *)(results.firstObject);
    } else {
        return nil;
    }
}

+ (User *)findByUUID:(NSString *)uuid inContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [self fetchRequest];
    NSPredicate *uuidPredicate = [NSPredicate predicateWithFormat:@"uuid = %@", uuid];
    [request setPredicate:uuidPredicate];
    NSArray *results = [self p_executeFetchRequest:request inContext:context];
    
    if (results) {
        return (User *)(results.firstObject);
    } else {
        return nil;
    }

}

#pragma mark - Private methods

+ (NSArray *)p_executeFetchRequest:(NSFetchRequest *)fetchRequest inContext:(NSManagedObjectContext *)context {
    NSError *error;
    NSArray *results = [context executeFetchRequest:fetchRequest error:&error];
    
    if (error) {
        NSLog(@"%@", error.localizedDescription);
    }
    
    if (results.count > 0) {
        return results;
    } else {
        return nil;
    }
}

@end
