
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CurrencyExchangeValueChangingDelegate <NSObject>

- (void)userChangedExchangeValue:(NSNumber * _Nullable)newValue;

@end

NS_ASSUME_NONNULL_END
