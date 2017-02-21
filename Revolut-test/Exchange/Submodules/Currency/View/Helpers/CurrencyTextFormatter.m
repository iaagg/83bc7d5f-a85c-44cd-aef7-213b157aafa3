
#import <UIKit/UIKit.h>
#import "CurrencyTextFormatter.h"

static NSString * const kRevolutDepositStringPrefix = @"You have ";
static NSInteger const kRevolutCurrencySymbolFontSize = 8;
static NSInteger const kRevolutCurrencySymbolFontSizeInNavigationBar = 10;
static NSInteger const kRevolutCurrencyRateLastDigitsFontSize = 6;
static NSInteger const kRevolutCountOfLastRateDigitsToBeResizedInNavigationBar = 2;
static NSInteger const kRevolutCountOfLastRateDigitsToBeResizedInToCurrency = 0;

@implementation CurrencyTextFormatter

+ (instancetype)shared {
    static CurrencyTextFormatter *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [CurrencyTextFormatter new];
    });
    
    return instance;
}

- (NSAttributedString *)makeDepositStringWithAmount:(NSInteger)amount
                                             symbol:(NSString *)symbol
                                          labelFont:(UIFont *)font {
    
    NSDictionary *attributes = @{NSFontAttributeName: font};
    NSString *outputString = [NSString stringWithFormat:@"%@%@%ld", kRevolutDepositStringPrefix, symbol, (long)amount];
    NSMutableAttributedString *attrOutputString = [[NSMutableAttributedString alloc] initWithString:outputString attributes:attributes];
    
    //Changing font size of currency symbol
    UIFont *symbolFont = [font fontWithSize:kRevolutCurrencySymbolFontSize];
    NSRange rangeOfSymbol = [outputString rangeOfString:symbol];
    [attrOutputString addAttribute:NSFontAttributeName value:symbolFont range:rangeOfSymbol];
    return [attrOutputString copy];
}

- (NSAttributedString *)makeRateStringWithFromCurrency:(NSString *)fromCurrency
                                            toCurrency:(NSString *)toCurrency
                                                  rate:(double)rate
                                             labelFont:(UIFont *)font
                                                  from:(BOOL)from {
    
    NSDictionary *attributes = @{NSFontAttributeName: font};
    NSString *outputString;
    UIFont *symbolFont;
    NSRange rangeOfLastDigitsToResize;
    
    //Special setup for different currency rate labels
    if (from) {
        outputString = [NSString stringWithFormat:@"%@1 = %@%.4f", fromCurrency, toCurrency, rate];
        rangeOfLastDigitsToResize = NSMakeRange(outputString.length - kRevolutCountOfLastRateDigitsToBeResizedInNavigationBar, kRevolutCountOfLastRateDigitsToBeResizedInNavigationBar);

        symbolFont = [font fontWithSize:kRevolutCurrencySymbolFontSizeInNavigationBar];
    } else {
        outputString = [NSString stringWithFormat:@"%@1 = %@%.2f", fromCurrency, toCurrency, rate];
        rangeOfLastDigitsToResize = NSMakeRange(outputString.length - kRevolutCountOfLastRateDigitsToBeResizedInToCurrency, kRevolutCountOfLastRateDigitsToBeResizedInToCurrency);
        symbolFont = [font fontWithSize:kRevolutCurrencySymbolFontSize];
    }
    NSMutableAttributedString *attrOutputString = [[NSMutableAttributedString alloc] initWithString:outputString attributes:attributes];
    
    //Changing font size of fromCurrency symbol
    NSRange rangeOfFromSymbol = [outputString rangeOfString:fromCurrency];
    [attrOutputString addAttribute:NSFontAttributeName value:symbolFont range:rangeOfFromSymbol];
    
    //Changing font size of fromCurrency symbol
    NSRange rangeOfToSymbol = [outputString rangeOfString:toCurrency];
    [attrOutputString addAttribute:NSFontAttributeName value:symbolFont range:rangeOfToSymbol];
    
    //Changing font size of last rate digits
    UIFont *rateFont = [font fontWithSize:kRevolutCurrencyRateLastDigitsFontSize];
    [attrOutputString addAttribute:NSFontAttributeName value:rateFont range:rangeOfLastDigitsToResize];
    
    
    return [attrOutputString copy];
}

@end
