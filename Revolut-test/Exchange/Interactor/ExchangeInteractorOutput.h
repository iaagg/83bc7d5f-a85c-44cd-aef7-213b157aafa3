
#import <Foundation/Foundation.h>
@class PONSO_User, CurrencyRate;

@protocol ExchangeInteractorOutput <NSObject>

#pragma mark - Neywork requests results

/*! 
 * @discussion Notifies about start of requesting currencies rates 
 */
- (void)didStartFetchingCurrenciesRates;

/*!
 * @discussion Notifies about received currencies rates.
 * @param currenciesRates Parsed currencies rates to euro currency.
 */
- (void)didFetchCurrenciesRates:(NSArray<NSDictionary *> *)currenciesRates;

/*!
 * @discussion Notifies about error during retrieving currencies rates.
 */
- (void)didFailedFetchingCurrenciesRates;

/*!
 * @discussion Notifies about successfully finished request for currencies rates.
 */
- (void)didFinishFetchingCurrenciesRates;

#pragma mark - DB operations results

/*!
 * @discussion Notifies about start of requesting currencies rates
 * @param user PONSO_User object parsed from fetched User object (NSManagedObject)
 */
- (void)didFetchDefaultUser:(PONSO_User *)user;

/*!
 * @discussion Notifies about creating currency rate for displaying in navigation bar.
 * @param currencyRate CurrencyRate object
 */
- (void)didMakeExchangingFromCurrencyRate:(CurrencyRate *)currencyRate;

/*!
 * @discussion Notifies about creating currency rate for displaying in view for currency which user would receive after conversion.
 * @param currencyRate CurrencyRate object
 */
- (void)didMakeExchangingToCurrencyRate:(CurrencyRate *)currencyRate;

/*!
 * @discussion Notifies about creating amount of currency which would be received after exchanging.
 * @param value Amount of currency which would be received.
 */
- (void)didCountValueAfterExchange:(NSNumber *)value;

#pragma mark - Updating data

/*!
 * @discussion Notifies about finished exchanging.
 */
- (void)didFinishExchange;

@end
