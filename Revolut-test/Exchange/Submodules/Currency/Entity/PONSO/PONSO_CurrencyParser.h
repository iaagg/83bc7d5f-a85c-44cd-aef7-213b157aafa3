
#import <Foundation/Foundation.h>
@class Currency, PONSO_Currency;

@interface PONSO_CurrencyParser : NSObject

+ (PONSO_Currency *)parseCoreDataCurrency:(Currency *)currency;

@end
