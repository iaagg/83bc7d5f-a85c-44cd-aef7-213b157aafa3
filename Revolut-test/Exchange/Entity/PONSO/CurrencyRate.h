
#import <Foundation/Foundation.h>

@interface CurrencyRate : NSObject

@property (strong, nonatomic, readonly) NSString  *fromCurrency;
@property (strong, nonatomic, readonly) NSString  *toCurrency;
@property (assign, nonatomic, readonly) double    rate;

- (instancetype)initWithFromCurrency:(NSString *)fromCurrency
                          toCurrency:(NSString *)toCurrency
                                rate:(double)rate;

@end
