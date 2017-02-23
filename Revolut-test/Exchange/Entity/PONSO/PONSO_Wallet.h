
#import <Foundation/Foundation.h>
@class PONSO_Currency, PONSO_User;

@interface PONSO_Wallet : NSObject

/*! @brief Array of PONSO_Currency objects */
@property (strong, nonatomic) NSArray<PONSO_Currency *> *currencies;

@end
