
#import <Foundation/Foundation.h>

@interface CurrencyTextFormatter : NSObject

+ (instancetype)shared;

- (NSAttributedString *)makeDepositStringWithAmount:(NSInteger)amount
                                             symbol:(NSString *)symbol
                                          labelFont:(UIFont *)font;

- (NSAttributedString *)makeRateStringWithFromCurrency:(NSString *)fromCurrency
                                            toCurrency:(NSString *)toCurrency
                                                  rate:(double)rate
                                             labelFont:(UIFont *)font
                                                  from:(BOOL)from;

@end
