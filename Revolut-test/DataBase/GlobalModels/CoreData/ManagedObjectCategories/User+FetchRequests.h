
#import "User+CoreDataClass.h"

@interface User (FetchRequests)

+ (User *)findByName:(NSString *)name inContext:(NSManagedObjectContext *)context;

@end
