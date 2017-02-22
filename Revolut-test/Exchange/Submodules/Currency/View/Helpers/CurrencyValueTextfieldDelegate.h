
#import <UIKit/UIKit.h>
#import "CurrencyExchangeValueChangingDelegate.h"

@interface CurrencyValueTextfieldDelegate : NSObject <UITextFieldDelegate>

- (instancetype)initWithValueChangingDelegate:(id<CurrencyExchangeValueChangingDelegate>)delegate;

@end
