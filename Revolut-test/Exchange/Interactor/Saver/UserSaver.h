
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class PONSO_User, User;

@interface UserSaver : NSObject

+ (void)savePonsoUser:(PONSO_User *)ponsoUser toCoreDataUser:(User *)user inBgContext:(NSManagedObjectContext *)context;

@end
