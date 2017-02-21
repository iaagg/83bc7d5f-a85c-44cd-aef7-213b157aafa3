
#import <Foundation/Foundation.h>
#import "CurrencyModuleInput.h"

@protocol CurrencyViewOutput <NSObject>

- (void)module:(void(^)(id<CurrencyModuleInput>fetchedModule))module;
- (void)viewIsReady;
- (void)makeDataSourceForCurrencyCollectionView;

//Currencies navigation
- (void)userSwitchedToCurrencyWithIndex:(NSInteger)index currencyViewType:(CurrencyViewType)currencyViewType;

@end
