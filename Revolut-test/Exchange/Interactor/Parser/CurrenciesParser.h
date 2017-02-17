
#import <Foundation/Foundation.h>
@class Currency;

@interface CurrenciesParser : NSObject

/*!
 * @discussion Only for seeding default amounts of currencies
 * @return Array of Currency objects created
 */
+ (NSArray<Currency *> *)parseSeedCurrencies;

@end
