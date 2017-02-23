
#import "User+CoreDataClass.h"

@interface User (FetchRequests)

/*!
 * @discussion Fetches first User object from db that matches provided name
 * @param name Username of user that should be fetched
 * @param context NSManagedObjectConatext object in witch fetch request should be executed
 * @return User object (NSMagedObject)
 */
+ (User *)findByName:(NSString *)name inContext:(NSManagedObjectContext *)context;

/*!
 * @discussion Fetches first User object from db that matches provided UUID
 * @param uuid UUID of user that should be fetched
 * @param context NSManagedObjectConatext object in witch fetch request should be executed
 * @return User object (NSMagedObject)
 */
+ (User *)findByUUID:(NSString *)uuid inContext:(NSManagedObjectContext *)context;

@end
