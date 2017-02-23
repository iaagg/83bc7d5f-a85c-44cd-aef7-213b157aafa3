
#import <Foundation/Foundation.h>
#import "CurrencyModuleInput.h"
@class PONSO_Wallet, CurrencyRate;

@protocol CurrencyViewInput <NSObject>

@property (weak, nonatomic, getter=p_fetchModule) id<CurrencyModuleInput> module;

#pragma mark - Interface updating

/*!
 * @discussion Message from presenter to setup view's initial state.
 * @param viewType Type of currency view controller.
 * @param currencyIndex Initial currency index (hardcoded 0 for test task)
 */
- (void)setupInitialStateWithViewType:(CurrencyViewType)viewType currencyIndex:(NSInteger)currencyIndex;

/*!
 * @discussion Notification from presenter after successfully performed exchange.
 */
- (void)reloadInterfaceAfterSuccessfulExchange;

#pragma Used only for "ToCurrencyType" view type

/*!
 * @discussion Notification from presenter for updating currency rate.
 * @param currencyRate Currency rate object for displaying of the rate.
 */
- (void)updateCurrencyRateLabelWithRate:(CurrencyRate *)currencyRate;

/*!
 * @discussion Notification from presenter for updating exchange result.
 * @param value Ammount of currency which would be received after conversion.
 */
- (void)updateExchangeResultLabelWithValue:(NSNumber *)value;

#pragma mark - Receiving data

/*!
 * @discussion Response from presenter with created data source.
 * @param dataSource DataSource array for collection view
 */
- (void)didMakeDataSourceForCurrencyCollectionView:(NSArray *)dataSource;

#pragma mark - Requests from parent module

/*!
 * @discussion Request from parent module to perform exceeding the deposit checking.
 */
- (void)requestDepositExceedingInfo;

@end
