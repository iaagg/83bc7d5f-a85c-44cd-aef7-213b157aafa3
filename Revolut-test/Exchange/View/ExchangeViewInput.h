
#import <Foundation/Foundation.h>
#import "CurrencyRateView.h"
@class CurrencyRate;

@protocol ExchangeViewInput <NSObject>

/*!
 * @discussion Message from presenter to setup view's initial state
 */
- (void)setupInitialState;

#pragma mark - State updating

/*!
 * @discussion Updates CurrencyRateView in navigation bar to updating state
 */
- (void)setUpdatingCurrenciesRatesState;

/*!
 * @discussion Updates CurrencyRateView in Navigation bar to updated state
 * @param rate CurrencyRate object to be passed into CurrencyRateView in navigation bar
 */
- (void)setUpdatedCurrenciesRatesStateWith:(CurrencyRate *)rate;

/*!
 * @discussion Disables possibility of exchanging untill rates will be received
 */
- (void)setUpdatingCurrenciesRatesFailedState;

#pragma mark - Receiving subviews

/*!
 * @discussion Response from ExchangePresenter with created FROM currency controller
 * @param controller FROM currency controller to be added as a child view controller
 */
- (void)didMakeFromCurrencyController:(UIViewController *)controller;

/*!
 * @discussion Response from ExchangePresenter with created TO currency controller
 * @param controller TO currency controller to be added as a child view controller
 */
- (void)didMakeToCurrencyController:(UIViewController *)controller;

#pragma mark - Notifications

/*!
 * @discussion Notifies about exceeding currency deposit by current value to exchange
 * @param valueExceedsDeposit Was deposit exceeded or not bool value
 */
- (void)exchangeValueExceedsDeposit:(BOOL)valueExceedsDeposit;

/*!
 * @discussion Notifies about absence of value for exchanging
 */
- (void)noValueToExchange;

@end
