
#import "ExchangePresenter.h"
#import "CurrencyModuleInput.h"
#import "CurrencyViewController.h"
#import "PONSO_User.h"
#import "PONSO_Wallet.h"
#import "PONSO_Currency.h"
#import "CurrencyRateView.h"

static NSString * const kRevolutExchangeStoryboardName = @"Exchange";
static NSString * const kRevolutCurrencyViewControllerSB_ID = @"CurrencyViewController";

#define STORYBOARD [UIStoryboard storyboardWithName:kRevolutExchangeStoryboardName bundle:[NSBundle bundleForClass:[self class]]]

@interface ExchangePresenter ()

@property (strong, nonatomic) PONSO_User                *user;
@property (weak, nonatomic) id<CurrencyModuleInput>     fromCurrencySubModule;
@property (weak, nonatomic) id<CurrencyModuleInput>     toCurrencySubModule;
@property (strong, nonatomic) NSArray<NSDictionary *>   *currenciesRates;
@property (assign, nonatomic) NSInteger                 currentFromCurrencyIndex;
@property (assign, nonatomic) NSInteger                 currentToCurrencyIndex;
@property (strong, nonatomic) NSNumber                  *exchangeValue;

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
    [_interactor retryFetchingRates];
}

- (void)userChoosedToProcceedExchange {
    PONSO_Currency *fromCurrency = _user.wallet.currencies[_currentFromCurrencyIndex];
    PONSO_Currency *toCurrency = _user.wallet.currencies[_currentToCurrencyIndex];
    [_interactor proceedExchangeFromCurrency:fromCurrency toCurrency:toCurrency currenciesRates:_currenciesRates valueToExchange:_exchangeValue];
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
    [self p_performCurrencyRateUpdate];
}

- (void)didFinishExchange {
    _exchangeValue = nil;
    [_interactor savePonsoUser:_user];
    [_fromCurrencySubModule reloadInterface];
    [_toCurrencySubModule reloadInterface];
}

- (void)didMakeExchangeFromCurrencyRate:(CurrencyRate *)currencyRate {
    if (currencyRate) {
        [_view setUpdatedCurrenciesRatesStateWith:currencyRate];
    } else {
        [_view setUpdatingCurrenciesRatesFailedState];
    }
}

- (void)didMakeExchangeToCurrencyRate:(CurrencyRate *)currencyRate {
    if (currencyRate) {
        [self p_updateExchangeResultWithValue:_exchangeValue];
        [_toCurrencySubModule updateCurrencyRateLabelWithRate:currencyRate];
    } else {
        [_view setUpdatingCurrenciesRatesFailedState];
    }
}

- (void)didCountValueAfterExchange:(NSNumber *)value {
    [_toCurrencySubModule updateExchangeResultLabelWithValue:value];
}

#pragma mark - CurrencyModuleOutput

- (void)userSwitchedToCurrencyWithIndex:(NSInteger)index currencyViewType:(CurrencyViewType)currencyViewType {
    switch (currencyViewType) {
        case FromCurrencyType: {
            _currentFromCurrencyIndex = index;
            break;
        }
            
        case ToCurrencyType: {
            _currentToCurrencyIndex = index;
            break;
        }
            
        default:
            break;
    }
    
    [self p_refreshInterfaceDueToCurrenciesSwitching];
}

- (void)currencyExchangeValueWasUpdated:(NSNumber *)newValue {
    _exchangeValue = newValue;
    [self p_updateExchangeResultWithValue:newValue];
}

- (void)exchangeValueExceedsDeposit:(BOOL)valueExceedsDeposit {
    [_view exchangeValueExceedsDeposit:valueExceedsDeposit];
}

#pragma mark - Private methods

- (void)p_updateExchangeResultWithValue:(NSNumber *)newValue {
    if (newValue) {
        PONSO_Currency *fromCurrency = _user.wallet.currencies[_currentFromCurrencyIndex];
        PONSO_Currency *toCurrency = _user.wallet.currencies[_currentToCurrencyIndex];
        [_interactor countValueAfterExchangeFromCurrency:fromCurrency
                                              toCurrency:toCurrency
                                         currenciesRates:_currenciesRates
                                         valueToExchange:newValue];
    } else {
        [_toCurrencySubModule updateExchangeResultLabelWithValue:newValue];
    }
}

- (void)p_refreshInterfaceDueToCurrenciesSwitching {
    [self p_performCurrencyRateUpdate];
    [self p_updateExchangeResultWithValue:_exchangeValue];
}

- (CurrencyViewController *)p_instantiateCurrencyController {
    UIViewController *controller = [STORYBOARD instantiateViewControllerWithIdentifier:kRevolutCurrencyViewControllerSB_ID];
    CurrencyViewController *currencyController = (CurrencyViewController *)controller;
    return currencyController;
}

- (void)p_performCurrencyRateUpdate {
    if (_currenciesRates) {
        PONSO_Currency *fromCurrency = _user.wallet.currencies[_currentFromCurrencyIndex];
        PONSO_Currency *toCurrency = _user.wallet.currencies[_currentToCurrencyIndex];
        [_interactor makeExchangeFromCurrencyRateFromCurrency:fromCurrency
                                                   toCurrency:toCurrency
                                          withCurrenciesRates:_currenciesRates];
        [_interactor makeExchangeToCurrencyRateFromCurrency:toCurrency
                                                 toCurrency:fromCurrency
                                        withCurrenciesRates:_currenciesRates];
    }
}

@end
