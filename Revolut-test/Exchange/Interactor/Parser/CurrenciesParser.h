
#import <Foundation/Foundation.h>
#import "CurrenciesParserDelegate.h"
#import "CurrenciesParserProtocol.h"

extern NSString * const kRevolutCurrencyTitleKey;
extern NSString * const kRevolutCurrencyRateKey;

@class Currency;

@interface CurrenciesParser : NSObject <CurrenciesParserProtocol>

- (instancetype)initWithDelegate:(id<CurrenciesParserDelegate>)delegate;

/*!
 * @discussion Only for seeding default amounts of currencies
 * @return Array of Currency objects created
 */
+ (NSArray<Currency *> *)parseSeedCurrencies;

@end
