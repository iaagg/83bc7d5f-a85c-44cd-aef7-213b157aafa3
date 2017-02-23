
#import <Foundation/Foundation.h>
#import "CurrencyModuleOutput.h"
#import "CurrenciesViewTypes.h"
@class PONSO_Wallet, CurrencyRate;

@protocol CurrencyModuleInput <NSObject>

/*! @brief weak reference for parent module */
@property (weak, nonatomic) id<CurrencyModuleOutput> parentModule;

#pragma mark - Setup

/*!
 * @discussion Setting up of currency module.
 * @param wallet PONSO_Wallet object with currencies.
 * @param currencyViewType Currency view conntroller type.
 */
- (void)setupWithWallet:(PONSO_Wallet *)wallet currencyViewType:(CurrencyViewType)currencyViewType;

#pragma mark - Interface updating

/*!
 * @discussion Notifies module about updating of currencies.
 */
- (void)setUpdatingCurrenciesRatesFailedState;

/*!
 * @discussion Notifies module about need for reloading currency view controller.
 */
- (void)reloadInterface;

/*!
 * @discussion Notifies module about need for checking exceeding the deposit.
 */
- (void)requestDepositExceedingInfo;

/*!
 * @discussion Notifies module that new currency rate was recieved.
 * @param currencyRate CurrencyRate object for current currency.
 */
- (void)updateCurrencyRateLabelWithRate:(CurrencyRate *)currencyRate;

#pragma Used only for "ToCurrencyType" view type
/*!
 * @discussion Notifies module that new exchange result value was recieved.
 * @param value Exchange result value.
 */
- (void)updateExchangeResultLabelWithValue:(NSNumber *)value;

@end
