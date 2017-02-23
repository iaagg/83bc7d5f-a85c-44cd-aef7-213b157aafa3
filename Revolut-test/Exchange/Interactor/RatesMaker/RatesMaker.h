
#import <Foundation/Foundation.h>
@class CurrencyRate, PONSO_Currency;

@interface RatesMaker : NSObject

/*!
 * @discussion Creates CurrencyRate object
 * @param fromCurrency PONSO_Currency object for currency which would be converted
 * @param toCurrency PONSO_Currency object for currency which would be received after conversion
 * @param currenciesRates Parsed received rates of currencies with rates to euro currency.
 * @return CurrencyRate object
 */
+ (CurrencyRate *)currencyRateFromCurrency:(PONSO_Currency *)fromCurrency
                                toCurrency:(PONSO_Currency *)toCurrency
                       withCurrenciesRates:(NSArray<NSDictionary *> *)currenciesRates;

@end
