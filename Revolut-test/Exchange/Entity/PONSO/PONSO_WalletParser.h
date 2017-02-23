
#import <Foundation/Foundation.h>
@class Wallet, PONSO_Wallet;

@interface PONSO_WalletParser : NSObject

/*!
 * @discussion Creates PONSO_Wallet object inherited from NSObject with properties corresponding to CoreData Wallet object
 * @param wallet Wallet object (NSManagedObject)
 * @return PONSO_Wallet object inherited from NSObject
 */
+ (PONSO_Wallet *)parseCoreDataWallet:(Wallet *)wallet;

@end
