
#import <UIKit/UIKit.h>
#import "CurrencyExchangeValueChangingDelegate.h"

@interface CurrencyValueTextfieldDelegate : NSObject <UITextFieldDelegate>

/*!
 * @discussion Initializes CurrencyValueTextfieldDelegate object.
 * @param delegate Object conforming CurrencyExchangeValueChangingDelegate protocol.
 * @return CurrencyValueTextfieldDelegate object.
 */
- (instancetype)initWithValueChangingDelegate:(id<CurrencyExchangeValueChangingDelegate>)delegate;

@end
