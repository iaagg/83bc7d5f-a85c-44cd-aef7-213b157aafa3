
#import <Foundation/Foundation.h>

// "+" and "-" prefixes for displaying before corresponding currencies values
extern NSString * const kRevolutToCurrencyExchangeValuePrefix;
extern NSString * const kRevolutFromCurrencyExchangeValuePrefix;

@interface CurrencyTextFormatter : NSObject

/*!
 * @discussion Makes string for displaying in deposit label.
 * @param amount Deposit value.
 * @param symbol Unicode symbol of currency.
 * @param shouldHighlight BOOL value which determines should be deposit string colored or not.
 * @return Attributed string to display.
 */
+ (NSAttributedString *)makeDepositStringWithAmount:(double)amount
                                             symbol:(NSString *)symbol
                                    shouldHighlight:(BOOL)shouldHighlight;

/*!
 * @discussion Makes rate string for displaying.
 * @param fromCurrency Unicode symbol of currency which would be converted.
 * @param toCurrency Unicode symbol of currency which would be received after conversion.
 * @param rate Rate value.
 * @param from BOOL value which determines where would be created string displayed.
 * @code 
            YES = string would be displayed in navigation bar.
            NO  = string would be displayed in view for currency which user would receive after conversion.
 * @encode
 * @return Attributed string to display.
 */
+ (NSAttributedString *)makeRateStringWithFromCurrency:(NSString *)fromCurrency
                                            toCurrency:(NSString *)toCurrency
                                                  rate:(double)rate
                                                  from:(BOOL)from;

/*!
 * @discussion Makes exchange value string for displaying.
 * @param value Amount of currency which would be converted.
 * @return Attributed string to display.
 */
+ (NSAttributedString *)makeFromCurrencyValueStringWithValue:(NSNumber *)value;

/*!
 * @discussion Makes exchanged value string for displaying.
 * @param value Amount of currency which would be received after conversion.
 * @return Attributed string to display.
 */
+ (NSAttributedString *)makeToCurrencyValueStringWithValue:(NSNumber *)value;

@end
