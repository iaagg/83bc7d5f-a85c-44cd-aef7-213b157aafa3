
#import "CurrencyPresenter.h"

@interface CurrencyPresenter ()

@property (strong, nonatomic) PONSO_Wallet     *wallet;
@property (assign, nonatomic) CurrencyViewType currencyViewType;

@end

@implementation CurrencyPresenter

#pragma mark - CurrencyModuleInput

- (void)setupWithWallet:(PONSO_Wallet *)wallet currencyViewType:(CurrencyViewType)currencyViewType {
    _wallet = wallet;
    _currencyViewType = currencyViewType;
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

#pragma mark - CurrencyIntractorOutput

- (void)didMakeDataSourceForCurrencyCollectionView:(NSArray *)dataSource {
    [_view didMakeDataSourceForCurrencyCollectionView:dataSource];
}

@end
