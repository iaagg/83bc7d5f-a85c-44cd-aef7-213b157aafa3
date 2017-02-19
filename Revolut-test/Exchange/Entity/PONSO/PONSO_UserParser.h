
#import <Foundation/Foundation.h>
@class User, PONSO_User;

@interface PONSO_UserParser : NSObject

+ (PONSO_User *)parseCoreDataUser:(User *)user;

@end
