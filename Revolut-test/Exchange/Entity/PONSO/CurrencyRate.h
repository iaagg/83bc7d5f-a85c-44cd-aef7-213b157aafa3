
#import <Foundation/Foundation.h>

//Keys for dealing with rates (Parsing from XML / creating rates from rates dictionary)
extern NSString * const kRevolutCurrencyTitleKey;
extern NSString * const kRevolutCurrencyRateKey;

@interface CurrencyRate : NSObject

/*! @brief Contains unicode symbol of currency which would be converted */
@property (strong, nonatomic, readonly) NSString  *fromCurrency;

/*! @brief Contains unicode symbol of currency which would be received after conversion */
@property (strong, nonatomic, readonly) NSString  *toCurrency;

/*! @brief Shows value of funds which would be received after exchanging 1 unit of currency */
@property (assign, nonatomic, readonly) double    rate;

/*!
 * @discussion Initializes CurrencyRate object with provided properties
 * @param fromCurrency Unicode symbol of currency which would be converted
 * @param toCurrency Unicode symbol of currency hich would be received after conversion
 * @param rate Value of funds which would be received after exchanging 1 unit of currency
 * @return CurrencyRate object
 */
- (instancetype)initWithFromCurrency:(NSString *)fromCurrency
                          toCurrency:(NSString *)toCurrency
                                rate:(double)rate;

@end
