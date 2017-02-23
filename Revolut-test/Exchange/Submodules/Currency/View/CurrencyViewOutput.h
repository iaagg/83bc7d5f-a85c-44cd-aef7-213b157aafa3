
#import <Foundation/Foundation.h>
#import "CurrencyModuleInput.h"

@protocol CurrencyViewOutput <NSObject>

#pragma mark - VIPER methods

/*!
 * @discussion Provides object conforming CurrencyModuleInput protocol as block argument
 */
- (void)module:(void(^)(id<CurrencyModuleInput>fetchedModule))module;

/*!
 * @discussion Notifies presenter that view was loaded
 */
- (void)viewIsReady;

#pragma mark - Fetching data

/*!
 * @discussion Asks presenter for data source for collection view.
 */
- (void)makeDataSourceForCurrencyCollectionView;

#pragma mark - Notifications

/*!
 * @discussion Notifies about switching currency.
 * @param index Index of currency in user's wallet.
 * @param currencyViewType Type of currency view performing notification.
 */
- (void)userSwitchedToCurrencyWithIndex:(NSInteger)index currencyViewType:(CurrencyViewType)currencyViewType;

#pragma Used only for "FromCurrencyType" view type

/*!
 * @discussion Notifies about updating value for conversion.
 * @param newValue Amount of currency for conversion.
 */
- (void)currencyExchangeValueWasUpdated:(NSNumber *)newValue;

/*!
 * @discussion Notifies about results of exceeding the deposit checking.
 * @param valueExceedsDeposit Result of exceeding thr deposit checking.
 */
- (void)exchangeValueExceedsDeposit:(BOOL)valueExceedsDeposit;

@end
