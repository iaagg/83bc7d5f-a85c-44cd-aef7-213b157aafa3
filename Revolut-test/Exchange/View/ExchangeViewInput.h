
#import <Foundation/Foundation.h>
#import "CurrencyRateView.h"

@protocol ExchangeViewInput <NSObject>

- (void)setupInitialState;

//Receiving subviews
- (void)didMakeFromCurrencyController:(UIViewController *)controller;
- (void)didMakeToCurrencyController:(UIViewController *)controller;
- (void)didMakeCurrencyRateView:(CurrencyRateView *)currencyRateView;


@end
