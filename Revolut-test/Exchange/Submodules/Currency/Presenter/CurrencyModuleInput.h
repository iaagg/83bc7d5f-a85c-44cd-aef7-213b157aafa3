
#import <Foundation/Foundation.h>
#import "CurrencyModuleOutput.h"
#import "CurrenciesViewTypes.h"
@class PONSO_Wallet, CurrencyRate;

@protocol CurrencyModuleInput <NSObject>

@property (weak, nonatomic) id<CurrencyModuleOutput> parentModule;

- (void)setUpdatingCurrenciesRatesFailedState;
- (void)reloadInterface;
- (void)setupWithWallet:(PONSO_Wallet *)wallet currencyViewType:(CurrencyViewType)currencyViewType;
- (void)requestDepositExceedingInfo;
- (void)updateCurrencyRateLabelWithRate:(CurrencyRate *)currencyRate;
- (void)updateExchangeResultLabelWithValue:(NSNumber *)value;

@end
