
#import <Foundation/Foundation.h>
@class PONSO_User, CurrencyRate;

@protocol ExchangeInteractorOutput <NSObject>

- (void)didFetchDefaultUser:(PONSO_User *)user;
- (void)didStartFetchingCurrenciesRates;
- (void)didFetchCurrenciesRates:(NSArray<NSDictionary *> *)currenciesRates;
- (void)didFailedFetchingCurrenciesRates;
- (void)didFinishFetchingCurrenciesRates;

- (void)didMakeCurrencyRate:(CurrencyRate *)currencyRate;

@end
