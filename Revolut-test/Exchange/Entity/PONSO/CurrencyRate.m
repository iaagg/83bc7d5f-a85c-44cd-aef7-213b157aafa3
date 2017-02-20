
#import "CurrencyRate.h"

@interface CurrencyRate ()

@property (strong, nonatomic, readwrite) NSString  *fromCurrency;
@property (strong, nonatomic, readwrite) NSString  *toCurrency;
@property (assign, nonatomic, readwrite) double    rate;

@end

@implementation CurrencyRate

- (instancetype)initWithFromCurrency:(NSString *)fromCurrency
                          toCurrency:(NSString *)toCurrency
                                rate:(double)rate {
    if (self = [super init]) {
        _fromCurrency = fromCurrency;
        _toCurrency = toCurrency;
        _rate = rate;
    }
    
    return self;
}

@end
