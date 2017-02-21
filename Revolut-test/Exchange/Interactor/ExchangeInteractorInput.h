
#import <Foundation/Foundation.h>
@class PONSO_User, CurrencyRate, PONSO_Currency;

@protocol ExchangeInteractorInput <NSObject>

- (void)startFetchingRatesTask;
- (void)retryFetchingRates;
- (void)fetchDefaultUser;
- (void)savePonsoUser:(PONSO_User *)ponsoUser;

- (void)makeCurrencyRateFromCurrency:(PONSO_Currency *)fromCurrency
                          toCurrency:(PONSO_Currency *)toCurrency
                 withCurrenciesRates:(NSArray<NSDictionary *> *)currenciesRates;

@end
