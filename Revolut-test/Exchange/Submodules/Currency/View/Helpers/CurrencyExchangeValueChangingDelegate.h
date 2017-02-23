
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CurrencyExchangeValueChangingDelegate <NSObject>

/*!
 * @discussion Notifies about typing new value for exchange.
 * @param newValue Value for exchange
 */
- (void)userChangedExchangeValue:(NSNumber * _Nullable)newValue;

@end

NS_ASSUME_NONNULL_END
