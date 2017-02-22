
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

static NSString * const kRevolutToCurrencyExchangeValuePrefix = @"+ ";
static NSString * const kRevolutFromCurrencyExchangeValuePrefix = @"- ";

@protocol CurrencyExchangeValueChangingDelegate <NSObject>

- (void)userChangedEchangeValue:(NSNumber * _Nullable)newValue;

@end

NS_ASSUME_NONNULL_END
