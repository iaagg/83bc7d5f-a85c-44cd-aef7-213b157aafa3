
#import <Foundation/Foundation.h>

@protocol ExchangeViewOutput <NSObject>

- (void)viewIsReady;

//Fetching Subviews
- (void)makeFromCurrencyController;
- (void)makeToCurrencyController;
- (void)makeCurrencyRateView;

@end
