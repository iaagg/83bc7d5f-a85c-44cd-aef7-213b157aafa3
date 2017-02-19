
#import "User+CoreDataClass.h"

@interface User (FetchRequests)

+ (User *)findByName:(NSString *)name inContext:(NSManagedObjectContext *)context;
+ (User *)findByUUID:(NSString *)uuid inContext:(NSManagedObjectContext *)context;

@end
