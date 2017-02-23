
#import <Foundation/Foundation.h>
@class User, PONSO_User;

@interface PONSO_UserParser : NSObject

/*!
 * @discussion Creates PONSO_User object inherited from NSObject with properties corresponding to CoreData User object
 * @param user User object (NSManagedObject)
 * @return PONSO_User object inherited from NSObject
 */
+ (PONSO_User *)parseCoreDataUser:(User *)user;

@end
