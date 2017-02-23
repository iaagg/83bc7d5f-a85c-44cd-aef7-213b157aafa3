
#import <Foundation/Foundation.h>

@protocol CurrenciesParserDelegate <NSObject>

/*!
 * @discussion Notifies about successfully finished parsing of currencies rates
 * @param currenciesRates Parsed currencies rates. 
                          Array of dictionaries. Each dictionary represents some currency rate to euro currency
 */
- (void)parserDidParseCurrenciesRates:(NSArray<NSDictionary *> *)currenciesRates;

/*!
 * @discussion Notifies about error occured during parsing currencies rates
 */
- (void)errorOccuredWhileParsing;

@end
