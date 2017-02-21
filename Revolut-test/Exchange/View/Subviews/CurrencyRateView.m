
#import "CurrencyRateView.h"
#import "CurrencyTextFormatter.h"
#import "CurrencyRate.h"
#import "UIView+DefaultConstraints.h"

@interface CurrencyRateView ()

@property (weak, nonatomic) IBOutlet UILabel        *rateLabel;
@property (weak, nonatomic) UIActivityIndicatorView *indicator;

@end


@implementation CurrencyRateView

- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = [borderColor CGColor];
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
}

- (void)setUpdatingState {
    if (!_indicator) {
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _rateLabel.text = @" ";
        [self addToMarginsConstraintsForView:indicator];
        _indicator = indicator;
        [indicator startAnimating];
    }
}

- (void)updateRateWithCurrencyRate:(CurrencyRate *)currencyRate {
    [self p_stopIndicator];
    UIFont *labelFont = _rateLabel.font;
    _rateLabel.attributedText = [[CurrencyTextFormatter shared] makeRateStringWithFromCurrency:currencyRate.fromCurrency
                                                                                    toCurrency:currencyRate.toCurrency
                                                                                          rate:currencyRate.rate
                                                                                     labelFont:labelFont];
}

#pragma mark - Private methods

- (void)p_stopIndicator {
    if (_indicator) {
        [_indicator stopAnimating];
        [_indicator removeFromSuperview];
    }
}

@end
