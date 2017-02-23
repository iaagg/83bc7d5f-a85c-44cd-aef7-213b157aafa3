
#import <Foundation/Foundation.h>

@protocol CurrencyCollectionViewDataManagerDelegate <NSObject>

/*!
 * @discussion Notifies about switching to another currency by user.
 * @param index Index of currency in user's wallet.
 */
- (void)switchedToCurrencyWithIndex:(NSInteger)index;

/*!
 * @discussion Notifies about new typed value for exchanging.
 * @param newValue Amount of currency to exchange
 */
- (void)currencyExchangeValueWasUpdated:(NSNumber *)newValue;

/*!
 * @discussion Notifies results of exceeding the deposit checking.
 * @param valueExceedsDeposit BOOL result of checking
 * @code
            YES = typed amound exceeds the deposit
            NO  = typed amound doesn't exceed the deposit
 * @endcode
 */
- (void)exchangeValueExceedsDeposit:(BOOL)valueExceedsDeposit;

@end
