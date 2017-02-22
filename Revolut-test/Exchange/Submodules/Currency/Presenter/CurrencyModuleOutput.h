
#import <Foundation/Foundation.h>
#import "CurrenciesViewTypes.h"

@protocol CurrencyModuleOutput <NSObject>

- (void)userSwitchedToCurrencyWithIndex:(NSInteger)index currencyViewType:(CurrencyViewType)currencyViewType;
- (void)currencyExchangeValueWasUpdated:(NSNumber *)newValue;

@end
