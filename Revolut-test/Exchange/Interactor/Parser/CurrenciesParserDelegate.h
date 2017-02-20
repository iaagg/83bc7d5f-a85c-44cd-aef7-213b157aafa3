
#import <Foundation/Foundation.h>

@protocol CurrenciesParserDelegate <NSObject>

- (void)parserDidParseCurrenciesRates:(NSArray<NSDictionary *> *)currenciesRates;
- (void)errorOccuredWhileParsing;

@end
