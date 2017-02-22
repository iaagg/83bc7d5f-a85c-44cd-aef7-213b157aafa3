
#import <Foundation/Foundation.h>

@protocol ExchangeViewOutput <NSObject>

- (void)viewIsReady;

//User actions
- (void)userChoosedToRetryToUpdateCurrencies;
- (void)userChoosedToProcceedExchange;

//Fetching Subviews
- (void)makeFromCurrencyController;
- (void)makeToCurrencyController;

@end
