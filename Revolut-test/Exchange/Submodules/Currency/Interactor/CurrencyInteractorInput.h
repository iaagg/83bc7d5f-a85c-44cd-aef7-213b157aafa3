
#import <Foundation/Foundation.h>
@class PONSO_Wallet;

@protocol CurrencyInteractorInput <NSObject>

/*!
 * @discussion Request from presenter for data source for collection view.
 */
- (void)makeDataSourceForCurrencyCollectionViewWithWallet:(PONSO_Wallet *)wallet;

@end
