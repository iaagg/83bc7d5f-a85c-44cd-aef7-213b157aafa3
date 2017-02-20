
#import <UIKit/UIKit.h>
@class CurrencyRate;

IB_DESIGNABLE
@interface CurrencyRateView : UIView

@property (assign, nonatomic) IBInspectable CGFloat borderWidth;
@property (assign, nonatomic) IBInspectable UIColor *borderColor;
@property (assign, nonatomic) IBInspectable CGFloat cornerRadius;

- (void)setUpdatingState;
- (void)updateRateWithCurrencyRate:(CurrencyRate *)currencyRate;

@end
