
#import "PONSO_CurrencyParser.h"
#import "PONSO_Currency.h"
#import "Currency+CoreDataClass.h"

@implementation PONSO_CurrencyParser

+ (PONSO_Currency *)parseCoreDataCurrency:(Currency *)currency {
    PONSO_Currency *ponsoCurrency = [PONSO_Currency new];
    ponsoCurrency.amount = currency.amount;
    ponsoCurrency.symbol = currency.symbol;
    ponsoCurrency.title = currency.title;
    return ponsoCurrency;
}

@end
