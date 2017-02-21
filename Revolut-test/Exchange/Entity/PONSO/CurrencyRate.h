
#import <Foundation/Foundation.h>

extern NSString * const kRevolutCurrencyTitleKey;
extern NSString * const kRevolutCurrencyRateKey;

@interface CurrencyRate : NSObject

@property (strong, nonatomic, readonly) NSString  *fromCurrency;
@property (strong, nonatomic, readonly) NSString  *toCurrency;
@property (assign, nonatomic, readonly) double    rate;

- (instancetype)initWithFromCurrency:(NSString *)fromCurrency
                          toCurrency:(NSString *)toCurrency
                                rate:(double)rate;

@end
