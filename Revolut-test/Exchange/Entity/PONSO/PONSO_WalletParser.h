
#import <Foundation/Foundation.h>
@class Wallet, PONSO_Wallet;

@interface PONSO_WalletParser : NSObject

+ (PONSO_Wallet *)parseCoreDataWallet:(Wallet *)wallet;

@end
