
#import "PONSO_WalletParser.h"
#import "PONSO_Wallet.h"
#import "Wallet+CoreDataClass.h"
#import "PONSO_CurrencyParser.h"

@implementation PONSO_WalletParser

+ (PONSO_Wallet *)parseCoreDataWallet:(Wallet *)wallet {
    PONSO_Wallet *ponsoWallet = [PONSO_Wallet new];
    
    //Parsing currencies from wallet
    NSMutableArray *parsedCurrencies = [NSMutableArray array];
    NSArray *currenciesToParse = [wallet.currencies array];
    
    for (Currency *currency in currenciesToParse) {
        PONSO_Currency *ponsoCurrency = [PONSO_CurrencyParser parseCoreDataCurrency:currency];
        [parsedCurrencies addObject:ponsoCurrency];
    }
    
    ponsoWallet.currencies = [parsedCurrencies copy];
    
    return ponsoWallet;
}

@end
