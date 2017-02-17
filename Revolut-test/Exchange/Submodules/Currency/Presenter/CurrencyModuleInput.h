
#import <Foundation/Foundation.h>
#import "CurrencyModuleOutput.h"
@class PONSO_Wallet;

@protocol CurrencyModuleInput <NSObject>

@property (strong, nonatomic) PONSO_Wallet *wallet;
@property (weak, nonatomic) id<CurrencyModuleOutput> parentModule;

@end
