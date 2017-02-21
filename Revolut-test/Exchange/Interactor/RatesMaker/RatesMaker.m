
#import "RatesMaker.h"
#import "PONSO_Currency.h"
#import "CurrencyRate.h"

@implementation RatesMaker

+ (CurrencyRate *)currencyRateFromCurrency:(PONSO_Currency *)fromCurrency
                                toCurrency:(PONSO_Currency *)toCurrency
                       withCurrenciesRates:(NSArray<NSDictionary *> *)currenciesRates {
    CurrencyRate *currencyRate;
    double fromCurrencyRateToEuro = 0;
    double toCurrencyRateToEuro = 0;
    
    for (NSDictionary *dict in currenciesRates) {
        if ([dict[kRevolutCurrencyTitleKey] isEqualToString:fromCurrency.title]) {
            fromCurrencyRateToEuro = [dict[kRevolutCurrencyRateKey] doubleValue];
        }
        
        if ([dict[kRevolutCurrencyTitleKey] isEqualToString:toCurrency.title]) {
            toCurrencyRateToEuro = [dict[kRevolutCurrencyRateKey] doubleValue];
        }
    }
    
    if (fromCurrencyRateToEuro > 0 && toCurrencyRateToEuro > 0) {
        double rate = [self p_makeRateWithFromCurrencyRateToEuro:fromCurrencyRateToEuro
                                            toCurrencyRateToEuro:toCurrencyRateToEuro];
        
        currencyRate = [[CurrencyRate alloc] initWithFromCurrency:fromCurrency.symbol
                                                       toCurrency:toCurrency.symbol
                                                             rate:rate];
    }
    
    return currencyRate;
}

#pragma mark - Private methods

+ (double)p_makeRateWithFromCurrencyRateToEuro:(double)fromCurrencyRateToEuro
                          toCurrencyRateToEuro:(double)toCurrencyRateToEuro {
    double rate = toCurrencyRateToEuro / fromCurrencyRateToEuro;
    return rate;
}

@end
