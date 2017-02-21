
#import <Foundation/Foundation.h>
#import "CurrencyModuleOutput.h"
#import "CurrenciesViewTypes.h"
@class PONSO_Wallet;

@protocol CurrencyModuleInput <NSObject>

@property (weak, nonatomic) id<CurrencyModuleOutput> parentModule;

- (void)setupWithWallet:(PONSO_Wallet *)wallet currencyViewType:(CurrencyViewType)currencyViewType;

@end
