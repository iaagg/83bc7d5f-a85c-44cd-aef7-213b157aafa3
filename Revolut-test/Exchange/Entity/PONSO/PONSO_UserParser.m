
#import "PONSO_UserParser.h"
#import "PONSO_User.h"
#import "User+CoreDataClass.h"
#import "PONSO_WalletParser.h"
#import "PONSO_Wallet.h"

@implementation PONSO_UserParser

+ (PONSO_User *)parseCoreDataUser:(User *)user {
    PONSO_User *ponsoUser = [PONSO_User new];
    ponsoUser.username = user.username;
    ponsoUser.uuid = user.uuid;
    
    //Parsing wallet
    PONSO_Wallet *wallet = [PONSO_WalletParser parseCoreDataWallet:user.wallet];
    ponsoUser.wallet = wallet;
    
    return ponsoUser;
}

@end
