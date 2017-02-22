
#import "CurrencyValueTextfieldDelegate.h"

@interface CurrencyValueTextfieldDelegate ()

@property (weak, nonatomic) id<CurrencyExchangeValueChangingDelegate> delegate;

@end

@implementation CurrencyValueTextfieldDelegate

- (instancetype)initWithValueChangingDelegate:(id<CurrencyExchangeValueChangingDelegate>)delegate {
    if (self = [super init]) {
        _delegate = delegate;
    }
    
    return self;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSString *newStringWithoutPrefix = [self p_exchangeValueWithoutPrefix:newString];
    
    if (newStringWithoutPrefix.length == 0) {
        [_delegate userChangedEchangeValue:nil];
        textField.text = newStringWithoutPrefix;
        return NO;
    } else {
        double value = [newStringWithoutPrefix doubleValue];
        [_delegate userChangedEchangeValue:[NSNumber numberWithDouble:value]];
        textField.text = [self p_exchangeValueWithPrefix:newStringWithoutPrefix];
        return NO;
    }
}

#pragma mark - Private methods

- (NSString *)p_exchangeValueWithoutPrefix:(NSString *)valueWithPrefix {
    NSString *value = [valueWithPrefix stringByReplacingOccurrencesOfString:kRevolutFromCurrencyExchangeValuePrefix
                                                                 withString:@""];
    return value;
}

- (NSString *)p_exchangeValueWithPrefix:(NSString *)valueWithoutPrefix {
    NSRange rangeOfPrefix = [valueWithoutPrefix rangeOfString:kRevolutFromCurrencyExchangeValuePrefix];
    NSString *outputString = valueWithoutPrefix;
    
    if (rangeOfPrefix.location == NSNotFound) {
        outputString = [NSString stringWithFormat:@"%@%@", kRevolutFromCurrencyExchangeValuePrefix, valueWithoutPrefix];
    }
    
    return outputString;
}

@end
