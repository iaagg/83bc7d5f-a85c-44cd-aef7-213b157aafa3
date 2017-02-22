
#import <Foundation/Foundation.h>

extern NSString * const kRevolutToCurrencyExchangeValuePrefix;
extern NSString * const kRevolutFromCurrencyExchangeValuePrefix;

@interface CurrencyTextFormatter : NSObject

+ (NSAttributedString *)makeDepositStringWithAmount:(double)amount
                                             symbol:(NSString *)symbol
                                    shouldHighlight:(BOOL)shouldHighlight;

+ (NSAttributedString *)makeRateStringWithFromCurrency:(NSString *)fromCurrency
                                            toCurrency:(NSString *)toCurrency
                                                  rate:(double)rate
                                                  from:(BOOL)from;

+ (NSAttributedString *)makeFromCurrencyValueStringWithValue:(NSNumber *)value;
+ (NSAttributedString *)makeToCurrencyValueStringWithValue:(NSNumber *)value;

@end
