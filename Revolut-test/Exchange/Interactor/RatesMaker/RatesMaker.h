
#import <Foundation/Foundation.h>
@class CurrencyRate, PONSO_Currency;

@interface RatesMaker : NSObject

+ (CurrencyRate *)currencyRateFromCurrency:(PONSO_Currency *)fromCurrency
                                toCurrency:(PONSO_Currency *)toCurrency
                       withCurrenciesRates:(NSArray<NSDictionary *> *)currenciesRates;

@end
