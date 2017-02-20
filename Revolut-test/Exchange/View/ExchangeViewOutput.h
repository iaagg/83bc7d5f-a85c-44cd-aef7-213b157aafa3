
#import <Foundation/Foundation.h>

@protocol ExchangeViewOutput <NSObject>

- (void)viewIsReady;

//User actions
- (void)userChoosedToRetryToUpdateCurrencies;

//Fetching Subviews
- (void)makeFromCurrencyController;
- (void)makeToCurrencyController;

@end
