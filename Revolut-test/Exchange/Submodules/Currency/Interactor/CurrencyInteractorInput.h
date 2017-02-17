
#import <Foundation/Foundation.h>
@class PONSO_Wallet;

@protocol CurrencyInteractorInput <NSObject>

- (void)makeDataSourceForCurrencyCollectionViewWithWallet:(PONSO_Wallet *)wallet;

@end
