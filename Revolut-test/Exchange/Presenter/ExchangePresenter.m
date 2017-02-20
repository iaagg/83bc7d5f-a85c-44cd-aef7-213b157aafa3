
#import "ExchangePresenter.h"
#import "CurrencyModuleInput.h"
#import "CurrencyViewController.h"
#import "PONSO_User.h"
#import "CurrencyRateView.h"

static NSString * const kRevolutExchangeStoryboardName = @"Exchange";
static NSString * const kRevolutCurrencyViewControllerSB_ID = @"CurrencyViewController";

#define STORYBOARD [UIStoryboard storyboardWithName:kRevolutExchangeStoryboardName bundle:[NSBundle bundleForClass:[self class]]]

@interface ExchangePresenter ()

@property (strong, nonatomic) PONSO_User                *user;
@property (weak, nonatomic) id<CurrencyModuleInput>     fromCurrencySubModule;
@property (weak, nonatomic) id<CurrencyModuleInput>     toCurrencySubModule;
@property (strong, nonatomic) NSArray<NSDictionary *>   *currenciesRates;

@end

@implementation ExchangePresenter

- (void)viewIsReady {
    [_interactor startFetchingRatesTask];
    [_interactor fetchDefaultUser];
    [self.view setupInitialState];
}

#pragma MARK - ExchangeViewOutput

- (void)makeFromCurrencyController {
    CurrencyViewController *currencyController = [self p_instantiateCurrencyController];
    _fromCurrencySubModule = currencyController.module;
    [_fromCurrencySubModule setupWithWallet:_user.wallet currencyViewType:FromCurrencyType];
    _fromCurrencySubModule.parentModule = self;
    [_view didMakeFromCurrencyController:currencyController];
}

- (void)makeToCurrencyController {
    CurrencyViewController *currencyController = [self p_instantiateCurrencyController];
    _toCurrencySubModule = currencyController.module;
    [_toCurrencySubModule setupWithWallet:_user.wallet currencyViewType:ToCurrencyType];
    _toCurrencySubModule.parentModule = self;
    [_view didMakeToCurrencyController:currencyController];
}

- (void)userChoosedToRetryToUpdateCurrencies {
    //TODO:
}

#pragma mark - ExchangeInteractorOutput

- (void)didFetchDefaultUser:(PONSO_User *)user {
    _user = user;
}

- (void)didStartFetchingCurrenciesRates {
    [_view setUpdatingCurrenciesRatesState];
}

- (void)didFetchCurrenciesRates:(NSArray<NSDictionary *> *)currenciesRates {
    _currenciesRates = currenciesRates;
}

- (void)didFailedFetchingCurrenciesRates {
    [_view setUpdatingCurrenciesRatesFailedState];
}

- (void)didFinishFetchingCurrenciesRates {
//    [_view setUpdatedCurrenciesRatesStateWith:<#(CurrencyRate *)#>];
}

#pragma mark - Private methods

- (CurrencyViewController *)p_instantiateCurrencyController {
    UIViewController *controller = [STORYBOARD instantiateViewControllerWithIdentifier:kRevolutCurrencyViewControllerSB_ID];
    CurrencyViewController *currencyController = (CurrencyViewController *)controller;
    return currencyController;
}

@end
