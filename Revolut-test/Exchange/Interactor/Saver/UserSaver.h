
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class PONSO_User, User;

@interface UserSaver : NSObject

/*!
 * @discussion Performs saving information from PONSO user to corresponding CoreData user in db
 * @param ponsoUser PONSO_User object which should be saved
 * @param user User object (NSManagedObject) which should be updated and saved
 * @param context NSManagedObjectContext in which saving should be ferformed (background context is adviced)
 */
+ (void)savePonsoUser:(PONSO_User *)ponsoUser toCoreDataUser:(User *)user inBgContext:(NSManagedObjectContext *)context;

@end
