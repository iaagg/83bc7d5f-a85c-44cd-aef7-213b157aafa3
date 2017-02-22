
#import <Foundation/Foundation.h>
#import "CurrencyModuleInput.h"
@class PONSO_Wallet, CurrencyRate;

@protocol CurrencyViewInput <NSObject>

@property (weak, nonatomic, getter=p_fetchModule) id<CurrencyModuleInput> module;

- (void)setupInitialStateWithViewType:(CurrencyViewType)viewType currencyIndex:(NSInteger)currencyIndex;
- (void)reloadInterface;
- (void)didMakeDataSourceForCurrencyCollectionView:(NSArray *)dataSource;

- (void)updateCurrencyRateLabelWithRate:(CurrencyRate *)currencyRate;
- (void)updateExchangeResultLabelWithValue:(NSNumber *)value;
- (void)setExchangingCurrencySavedValue:(NSNumber *)savedValue;

@end
