
#import <Foundation/Foundation.h>

@protocol ExchangeViewOutput <NSObject>

#pragma mark - VIPER methods

/*!
 * @discussion Notifies presenter that view was loaded
 */
- (void)viewIsReady;

#pragma mark - User actions

/*!
 * @discussion Notifies presenter that user tapped Exchange button
 */
- (void)userChoosedToProcceedExchange;

#pragma mark - Fetching Subviews

/*!
 * @discussion Asks presenter to create FROM currency view controller
 */
- (void)makeFromCurrencyController;

/*!
 * @discussion Asks presenter to create TO currency view controller
 */
- (void)makeToCurrencyController;

@end
