
#import <Foundation/Foundation.h>
@class PONSO_Wallet;

@interface PONSO_User : NSObject

@property (strong, nonatomic) NSString      *uuid;
@property (strong, nonatomic) NSString      *username;
@property (strong, nonatomic) PONSO_Wallet  *wallet;

@end
