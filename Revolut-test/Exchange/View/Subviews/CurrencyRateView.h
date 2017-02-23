
#import <UIKit/UIKit.h>
@class CurrencyRate;

IB_DESIGNABLE
@interface CurrencyRateView : UIView

@property (assign, nonatomic) IBInspectable CGFloat borderWidth;
@property (assign, nonatomic) IBInspectable UIColor *borderColor;
@property (assign, nonatomic) IBInspectable CGFloat cornerRadius;

/*!
 * @discussion Updates own state to updating one. 
               In this state activity indicator will be presented and rate value will be deleted.
 */
- (void)setUpdatingState;

/*!
 * @discussion Updates own state to one with rate value.
               In this state activity indicator will be hidden and rate value will be displayed.
 * @param currencyRate CurrencyRate object with rate info to display
 */
- (void)updateRateWithCurrencyRate:(CurrencyRate *)currencyRate;

@end
