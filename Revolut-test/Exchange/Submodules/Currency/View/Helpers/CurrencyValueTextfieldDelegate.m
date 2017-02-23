
#import "CurrencyValueTextfieldDelegate.h"
#import "CurrencyTextFormatter.h"

static NSInteger const kRevolutExchangeValueInputLimit = 3;

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
    
    //Limiting input
    if (newStringWithoutPrefix.length > kRevolutExchangeValueInputLimit) {
        return NO;
    }
    
    //If user typed new charecter or deleted some
    BOOL deleting = newString.length < textField.text.length;
    
    if (newStringWithoutPrefix.length == 0) {
        [_delegate userChangedExchangeValue:nil];
        textField.text = newStringWithoutPrefix;
        return NO;
    } else {
        
        //Avoiding deleting of prefix
        if (deleting) {
            if (NSLocationInRange(range.location, [self p_rangeOfPrefix])) {
                return NO;
            }
        }
        
        double value = [newStringWithoutPrefix doubleValue];
        [_delegate userChangedExchangeValue:[NSNumber numberWithDouble:value]];
        textField.text = [self p_exchangeValueWithPrefix:newStringWithoutPrefix];
        return NO;
    }
}

#pragma mark - Private methods

- (NSRange)p_rangeOfPrefix {
    NSRange range = NSMakeRange(0, kRevolutFromCurrencyExchangeValuePrefix.length);
    return range;
}

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
