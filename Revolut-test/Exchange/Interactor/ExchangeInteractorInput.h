
#import <Foundation/Foundation.h>
@class PONSO_User, CurrencyRate, PONSO_Currency;

@protocol ExchangeInteractorInput <NSObject>

#pragma mark - Network requests

/*!
 * @discussion Sends request for retrieving rates data + launches 30 sec period loop for resending request
 */
- (void)startFetchingRatesTask;

#pragma mark - DB operations

/*!
 * @discussion Test usage only. Fetches hardcoded default user from db.
 */
- (void)fetchDefaultUser;

/*!
 * @discussion Performs saving of modified PONSO_User object
 * @param ponsoUser PONSO_User object which updated information should be saved
 */
- (void)savePonsoUser:(PONSO_User *)ponsoUser;

#pragma mark - Exchange calculations

/*!
 * @discussion Asking for making exchanging currency rate for displaying in navigation bar. 
               This particular rate would be used for exchanging.
 * @param fromCurrency PONSO_Currency object for currency which would be converted.
 * @param toCurrency PONSO_Currency object for currency which would be received after conversion
 * @param currenciesRates Parsed currencies rates to euro currency.
 */
- (void)makeExchangingFromCurrencyRateFromCurrency:(PONSO_Currency *)fromCurrency
                                      toCurrency:(PONSO_Currency *)toCurrency
                             withCurrenciesRates:(NSArray<NSDictionary *> *)currenciesRates;

/*!
 * @discussion Asking for making exchanging currency rate for displaying in view for currency which user would receive after conversion. This particular rate would be used only for displaying.
 * @param fromCurrency PONSO_Currency object for currency which would be received after conversion
 * @param toCurrency PONSO_Currency object for currency which would be converted.
 * @param currenciesRates Parsed currencies rates to euro currency.
 */
- (void)makeExchangingToCurrencyRateFromCurrency:(PONSO_Currency *)fromCurrency
                                    toCurrency:(PONSO_Currency *)toCurrency
                           withCurrenciesRates:(NSArray<NSDictionary *> *)currenciesRates;

/*!
 * @discussion Asking for making amoung of currency which would be received after exchange.
 * @param fromCurrency PONSO_Currency object for currency which would be converted.
 * @param toCurrency PONSO_Currency object for currency which would be received after conversion
 * @param currenciesRates Parsed currencies rates to euro currency.
 * @param value Amount of currency which would be exchanged.
 */
- (void)countValueAfterExchangeFromCurrency:(PONSO_Currency *)fromCurrency
                                 toCurrency:(PONSO_Currency *)toCurrency
                            currenciesRates:(NSArray<NSDictionary *> *)currenciesRates
                            valueToExchange:(NSNumber *)value;

#pragma mark - Updating data

/*!
 * @discussion Asking for updating amounts of currencies in users wallet.
 * @param fromCurrency PONSO_Currency object for currency which would be decreased.
 * @param toCurrency PONSO_Currency object for currency which would be increased.
 * @param currenciesRates Parsed currencies rates to euro currency.
 * @param value Amount of currency which would be exchanged.
 */
- (void)proceedExchangeFromCurrency:(PONSO_Currency *)fromCurrency
                         toCurrency:(PONSO_Currency *)toCurrency
                    currenciesRates:(NSArray<NSDictionary *> *)currenciesRates
                    valueToExchange:(NSNumber *)value;


@end
