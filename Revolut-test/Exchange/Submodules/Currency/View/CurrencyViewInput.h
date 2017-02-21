
#import <Foundation/Foundation.h>
#import "CurrencyModuleInput.h"
@class PONSO_Wallet;

@protocol CurrencyViewInput <NSObject>

@property (weak, nonatomic, getter=p_fetchModule) id<CurrencyModuleInput> module;

- (void)setupInitialStateWithViewType:(CurrencyViewType)viewType currencyIndex:(NSInteger)currencyIndex;
- (void)didMakeDataSourceForCurrencyCollectionView:(NSArray *)dataSource;

@end
