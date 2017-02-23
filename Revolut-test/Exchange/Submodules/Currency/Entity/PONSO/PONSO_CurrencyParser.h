
#import <Foundation/Foundation.h>
@class Currency, PONSO_Currency;

@interface PONSO_CurrencyParser : NSObject

/*!
 * @discussion Creates PONSO_Currency object inherited from NSObject with properties corresponding to CoreData Currency object
 * @param currency Currency object (NSManagedObject)
 * @return PONSO_Currency object inherited from NSObject
 */
+ (PONSO_Currency *)parseCoreDataCurrency:(Currency *)currency;

@end
