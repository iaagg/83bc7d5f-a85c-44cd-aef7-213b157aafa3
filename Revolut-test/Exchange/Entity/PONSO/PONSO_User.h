
#import <Foundation/Foundation.h>
@class PONSO_Wallet;

@interface PONSO_User : NSObject

/*! @brief Username of user */
@property (strong, nonatomic) NSString      *username;

/*! @brief Unique id of user in db */
@property (strong, nonatomic) NSString      *uuid;

/*! @brief Wallet object */
@property (strong, nonatomic) PONSO_Wallet  *wallet;

@end
