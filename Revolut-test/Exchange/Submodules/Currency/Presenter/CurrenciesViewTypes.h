
#ifndef CurrenciesViewTypes_h
#define CurrenciesViewTypes_h

#import <Foundation/Foundation.h>

/*!
 * @typedef CurrencyViewType
 * @@brief Enumeration of currency view types.
 * @field FromCurrencyType - currency view controller which shows currency which would be converted.
 * @field ToCurrencyType - currency view controller which shows currency which would be received after conversion.
 */
typedef NS_ENUM(NSInteger, CurrencyViewType) {
    FromCurrencyType = 1,
    ToCurrencyType = 2
};

#endif
