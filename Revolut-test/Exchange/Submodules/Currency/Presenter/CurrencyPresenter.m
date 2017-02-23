
#import "CurrencyPresenter.h"

@interface CurrencyPresenter ()

@property (strong, nonatomic) PONSO_Wallet     *wallet;
@property (assign, nonatomic) CurrencyViewType currencyViewType;

@end

@implementation CurrencyPresenter

#pragma mark - CurrencyModuleInput

- (void)setUpdatingCurrenciesRatesFailedState {
    [self updateExchangeResultLabelWithValue:nil];
    [self updateCurrencyRateLabelWithRate:nil];
}

- (void)reloadInterface {
    [_view reloadInterfaceAfterSuccessfulExchange];
}

- (void)setupWithWallet:(PONSO_Wallet *)wallet currencyViewType:(CurrencyViewType)currencyViewType {
    _wallet = wallet;
    _currencyViewType = currencyViewType;
}

- (void)requestDepositExceedingInfo {
    [_view requestDepositExceedingInfo];
}

- (void)updateCurrencyRateLabelWithRate:(CurrencyRate *)currencyRate {
    [_view updateCurrencyRateLabelWithRate:currencyRate];
}

- (void)updateExchangeResultLabelWithValue:(NSNumber *)value {
    [_view updateExchangeResultLabelWithValue:value];
}

#pragma mark - CurrencyViewOutput

- (void)module:(void (^)(id<CurrencyModuleInput>))module {
    module(self);
}

- (void)viewIsReady {
    [_view setupInitialStateWithViewType:_currencyViewType currencyIndex:0];
}

- (void)makeDataSourceForCurrencyCollectionView {
    [_interactor makeDataSourceForCurrencyCollectionViewWithWallet:_wallet];
}

- (void)userSwitchedToCurrencyWithIndex:(NSInteger)index currencyViewType:(CurrencyViewType)currencyViewType {
    [_parentModule userSwitchedToCurrencyWithIndex:index currencyViewType:currencyViewType];
}

- (void)currencyExchangeValueWasUpdated:(NSNumber *)newValue {
    [_parentModule currencyExchangeValueWasUpdated:newValue];
}

- (void)exchangeValueExceedsDeposit:(BOOL)valueExceedsDeposit {
    [_parentModule exchangeValueExceedsDeposit:valueExceedsDeposit];
}

#pragma mark - CurrencyIntractorOutput

- (void)didMakeDataSourceForCurrencyCollectionView:(NSArray *)dataSource {
    [_view didMakeDataSourceForCurrencyCollectionView:dataSource];
}

@end
