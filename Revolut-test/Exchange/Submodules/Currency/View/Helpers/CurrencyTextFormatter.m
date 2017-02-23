
#import <UIKit/UIKit.h>
#import "CurrencyTextFormatter.h"

//Prefixes
NSString * const kRevolutToCurrencyExchangeValuePrefix = @"+ ";
NSString * const kRevolutFromCurrencyExchangeValuePrefix = @"- ";
static NSString * const kRevolutDepositStringPrefix = @"You have ";

//Internal values for attributing

//1. Font sizes
static CGFloat const kRevolutCurrencySymbolFontSize = 11;
static CGFloat const kRevolutCurrencySymbolFontSizeInNavigationBar = 13;
static CGFloat const kRevolutCurrencyRateLastDigitsFontSize = 10;
static CGFloat const kRevolutCurrencyValueLastDigitsFontSize = 20;
static CGFloat const kRevolutCurrencyValuePrefixFontSize = 20;

//2. Counts of symbols with attributes
static CGFloat const kRevolutCountOfLastRateDigitsToBeResizedInNavigationBar = 2;
static CGFloat const kRevolutCountOfLastRateDigitsToBeResizedInToCurrency = 0;
static CGFloat const kRevolutCountOfLastValueDigitsToBeResizedInToCurrency = 2;

//Fonts for attributes
#define DEPOSIT_LABEL_FONT          [UIFont systemFontOfSize:14.0]
#define EXCHANGE_VALUE_FONT         [UIFont systemFontOfSize:24.0]
#define NAVIGATION_BAR_RATE_FONT    [UIFont systemFontOfSize:17.0]
#define TO_CURRENCY_RATE_FONT       [UIFont systemFontOfSize:14.0]
#define CURRENCY_VALUE_FONT         [UIFont systemFontOfSize:32.0]

//Colors for attributes
#define DEPOSIT_HIGHLIGHT_COLOR     [UIColor colorWithRed:240./255. green:0. blue:2./255 alpha:1.0]

@implementation CurrencyTextFormatter

+ (NSAttributedString *)makeDepositStringWithAmount:(double)amount
                                             symbol:(NSString *)symbol
                                    shouldHighlight:(BOOL)shouldHighlight {
    NSDictionary *attributes = @{NSFontAttributeName: DEPOSIT_LABEL_FONT};
    NSString *outputString = [NSString stringWithFormat:@"%@%@%.2f", kRevolutDepositStringPrefix, symbol, amount];
    NSMutableAttributedString *attrOutputString = [[NSMutableAttributedString alloc] initWithString:outputString attributes:attributes];
    
    //Changing font size of currency symbol
    UIFont *symbolFont = [DEPOSIT_LABEL_FONT fontWithSize:kRevolutCurrencySymbolFontSize];
    NSDictionary *symbolAttributes = @{NSFontAttributeName: symbolFont};
    [self p_stringWithAttributedSymbols:symbol inString:outputString attributes:symbolAttributes stringToModify:attrOutputString];
    
    //Highlight if needed
    if (shouldHighlight) {
        NSDictionary *highlightAttribute = @{NSForegroundColorAttributeName: DEPOSIT_HIGHLIGHT_COLOR};
        [attrOutputString addAttributes:highlightAttribute range:NSMakeRange(0, outputString.length)];
    }
    
    return [attrOutputString copy];
}

+ (NSAttributedString *)makeRateStringWithFromCurrency:(NSString *)fromCurrency
                                            toCurrency:(NSString *)toCurrency
                                                  rate:(double)rate
                                                  from:(BOOL)from {
    
    NSDictionary *attributes;
    NSString *outputString;
    UIFont *rateFont;
    UIFont *symbolFont;
    NSRange rangeOfLastDigitsToResize;
    
    //Special setup for different currency rate labels
    if (from) {
        UIFont *font = NAVIGATION_BAR_RATE_FONT;
        attributes = @{NSFontAttributeName: font};
        outputString = [NSString stringWithFormat:@"%@1 = %@%.4f", fromCurrency, toCurrency, rate];
        rangeOfLastDigitsToResize = NSMakeRange(outputString.length - kRevolutCountOfLastRateDigitsToBeResizedInNavigationBar, kRevolutCountOfLastRateDigitsToBeResizedInNavigationBar);
        rateFont = [font fontWithSize:kRevolutCurrencyRateLastDigitsFontSize];
        symbolFont = [font fontWithSize:kRevolutCurrencySymbolFontSizeInNavigationBar];
    } else {
        UIFont *font = TO_CURRENCY_RATE_FONT;
        attributes = @{NSFontAttributeName: font};
        outputString = [NSString stringWithFormat:@"%@1 = %@%.2f", fromCurrency, toCurrency, rate];
        rangeOfLastDigitsToResize = NSMakeRange(outputString.length - kRevolutCountOfLastRateDigitsToBeResizedInToCurrency, kRevolutCountOfLastRateDigitsToBeResizedInToCurrency);
        rateFont = [font fontWithSize:kRevolutCurrencyRateLastDigitsFontSize];
        symbolFont = [font fontWithSize:kRevolutCurrencySymbolFontSize];
    }
    NSMutableAttributedString *attrOutputString = [[NSMutableAttributedString alloc] initWithString:outputString
                                                                                         attributes:attributes];
    
    //Changing font size of currency symbols
    NSDictionary *symbolAttributes = @{NSFontAttributeName: symbolFont};
    
    //1. first symbol
    [self p_stringWithAttributedSymbols:fromCurrency
                               inString:outputString
                             attributes:symbolAttributes
                         stringToModify:attrOutputString];
    
    //2 .second symbol
    [self p_stringWithAttributedSymbols:toCurrency
                               inString:outputString
                             attributes:symbolAttributes
                         stringToModify:attrOutputString];
    
    
    //Changing font size of last rate digits
    [attrOutputString addAttribute:NSFontAttributeName value:rateFont range:rangeOfLastDigitsToResize];
    
    return [attrOutputString copy];
}

+ (NSAttributedString *)makeFromCurrencyValueStringWithValue:(NSNumber *)value {
    NSDictionary *defaultAttributes = @{NSFontAttributeName: CURRENCY_VALUE_FONT};
    NSString *outputString = [NSString stringWithFormat:@"%@%@", kRevolutFromCurrencyExchangeValuePrefix, value];
    NSMutableAttributedString *attrOutputString = [[NSMutableAttributedString alloc] initWithString:outputString
                                                                                         attributes:defaultAttributes];
    
    //Changing font size of prefix
    [self p_changeFontOfPrefixInString:outputString
                                prefix:kRevolutFromCurrencyExchangeValuePrefix
                        stringToModify:attrOutputString];
    
    return attrOutputString;
}

+ (NSAttributedString *)makeToCurrencyValueStringWithValue:(NSNumber *)value {
    NSDictionary *defaultAttributes = @{NSFontAttributeName: CURRENCY_VALUE_FONT};
    double valueAsDouble = [value doubleValue];
    NSString *outputString = [NSString stringWithFormat:@"%@%.2f", kRevolutToCurrencyExchangeValuePrefix, valueAsDouble];
    NSMutableAttributedString *attrOutputString = [[NSMutableAttributedString alloc] initWithString:outputString
                                                                                         attributes:defaultAttributes];
    
    //Changing font size of prefix
    [self p_changeFontOfPrefixInString:outputString
                                prefix:kRevolutToCurrencyExchangeValuePrefix
                        stringToModify:attrOutputString];
    
    //Changing font size of last rate digits
    UIFont *lastDigitsFont = [CURRENCY_VALUE_FONT fontWithSize:kRevolutCurrencyValueLastDigitsFontSize];
    NSRange rangeOfLastDigitsToResize = NSMakeRange(outputString.length - kRevolutCountOfLastValueDigitsToBeResizedInToCurrency, kRevolutCountOfLastValueDigitsToBeResizedInToCurrency);
    [attrOutputString addAttribute:NSFontAttributeName value:lastDigitsFont range:rangeOfLastDigitsToResize];
    
    return attrOutputString;
}

#pragma mark - Private methods

+ (NSMutableAttributedString *)p_changeFontOfPrefixInString:(NSString *)inputString prefix:(NSString *)prefix stringToModify:(NSMutableAttributedString *)attrOutputString {
    UIFont *prefixFont = [CURRENCY_VALUE_FONT fontWithSize:kRevolutCurrencyValuePrefixFontSize];
    NSRange rangeOfPrefix = [inputString rangeOfString:prefix];
    [attrOutputString addAttribute:NSFontAttributeName value:prefixFont range:rangeOfPrefix];
    return attrOutputString;
}

//Adding attributes to each found occurence of provided symbol in string.
+ (NSMutableAttributedString *)p_stringWithAttributedSymbols:(NSString *)symbol inString:(NSString *)inputString attributes:(NSDictionary *)attributes stringToModify:(NSMutableAttributedString *)outputString {
    BOOL symbolsExist = [inputString containsString:symbol];
    
    if (symbolsExist) {
        NSRange rangeOfSymbol = [inputString rangeOfString:symbol];
        NSInteger searchStartIndex = 0;
        NSString *nextString = inputString;
        
        while (rangeOfSymbol.location != NSNotFound) {
            nextString = [inputString substringFromIndex:searchStartIndex];
            rangeOfSymbol = [nextString rangeOfString:symbol];
            
            if (rangeOfSymbol.location != NSNotFound) {
                NSRange foundRange = NSMakeRange(searchStartIndex + rangeOfSymbol.location, rangeOfSymbol.length);
                [outputString addAttributes:attributes range:foundRange];
                searchStartIndex = foundRange.location + foundRange.length;
            }
        }
    }

    return outputString;
}

@end
