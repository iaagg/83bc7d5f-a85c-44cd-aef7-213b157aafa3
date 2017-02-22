
#import <Foundation/Foundation.h>

@protocol CurrencyExchangeValueChangingDelegate <NSObject>

- (void)userChangedEchangeValue:(NSNumber * _Nullable)newValue;

@end
