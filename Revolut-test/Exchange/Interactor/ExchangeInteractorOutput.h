
#import <Foundation/Foundation.h>
@class PONSO_User;

@protocol ExchangeInteractorOutput <NSObject>

- (void)didFetchDefaultUser:(PONSO_User *)user;
- (void)didStartFetchingCurrenciesRates;
- (void)didFetchCurrenciesRates:(NSArray<NSDictionary *> *)currenciesRates;
- (void)didFailedFetchingCurrenciesRates;
- (void)didFinishFetchingCurrenciesRates;

@end
