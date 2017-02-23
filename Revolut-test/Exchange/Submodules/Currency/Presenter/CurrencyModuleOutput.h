
#import <Foundation/Foundation.h>
#import "CurrenciesViewTypes.h"

@protocol CurrencyModuleOutput <NSObject>

/*!
 * @discussion Notifies parent module about switching currency.
 * @param index Index of currency in user's wallet.
 * @param currencyViewType Type of currency view performing notification.
 */
- (void)userSwitchedToCurrencyWithIndex:(NSInteger)index currencyViewType:(CurrencyViewType)currencyViewType;

/*!
 * @discussion Notifies parent module about updating value for conversion.
 * @param newValue Amount of currency for conversion.
 */
- (void)currencyExchangeValueWasUpdated:(NSNumber *)newValue;

/*!
 * @discussion Notifies parent module about results of exceeding the deposit checking.
 * @param valueExceedsDeposit Result of exceeding thr deposit checking.
 */
- (void)exchangeValueExceedsDeposit:(BOOL)valueExceedsDeposit;

@end
