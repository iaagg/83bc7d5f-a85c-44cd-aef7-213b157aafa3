
#import <Foundation/Foundation.h>
#import "CurrencyRateView.h"
@class CurrencyRate;

@protocol ExchangeViewInput <NSObject>

- (void)setupInitialState;

//State updating
- (void)setUpdatingCurrenciesRatesState;
- (void)setUpdatedCurrenciesRatesStateWith:(CurrencyRate *)rate;
- (void)setUpdatingCurrenciesRatesFailedState;

//Receiving subviews
- (void)didMakeFromCurrencyController:(UIViewController *)controller;
- (void)didMakeToCurrencyController:(UIViewController *)controller;

//Notifications
- (void)exchangeValueExceedsDeposit:(BOOL)valueExceedsDeposit;

@end
