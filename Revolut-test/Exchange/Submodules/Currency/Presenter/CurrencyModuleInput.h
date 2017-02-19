
#import <Foundation/Foundation.h>
#import "CurrencyModuleOutput.h"
@class PONSO_Wallet;

typedef NS_ENUM(NSInteger, CurrencyViewType) {
    FromCurrencyType = 1,
    ToCurrencyType = 2
};

@protocol CurrencyModuleInput <NSObject>

@property (weak, nonatomic) id<CurrencyModuleOutput> parentModule;

- (void)setupWithWallet:(PONSO_Wallet *)wallet currencyViewType:(CurrencyViewType)currencyViewType;

@end
