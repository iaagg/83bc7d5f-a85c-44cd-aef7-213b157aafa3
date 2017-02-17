
#import "ExchangePresenter.h"
#import "CurrencyModuleInput.h"
#import "CurrencyViewController.h"
#import "PONSO_User.h"

static NSString * const kRevolutExchangeStoryboardName = @"Exchange";
static NSString * const kRevolutCurrencyViewControllerSB_ID = @"CurrencyViewController";

#define STORYBOARD [UIStoryboard storyboardWithName:kRevolutExchangeStoryboardName bundle:[NSBundle bundleForClass:[self class]]]

@interface ExchangePresenter ()

@property (strong, nonatomic) PONSO_User            *user;
@property (weak, nonatomic) id<CurrencyModuleInput> fromCurrencySubModule;
@property (weak, nonatomic) id<CurrencyModuleInput> toCurrencySubModule;

@end

@implementation ExchangePresenter

- (void)viewIsReady {
    [_interactor fetchDefaultUser];
    [self.view setupInitialState];
}

#pragma MARK - ExchangeViewOutput

- (void)makeFromCurrencyController {
    CurrencyViewController *currencyController = [self p_instantiateCurrencyController];
    _fromCurrencySubModule = currencyController.module;
    _fromCurrencySubModule.wallet = _user.wallet;
    _fromCurrencySubModule.parentModule = self;
    [_view didMakeFromCurrencyController:currencyController];
}

- (void)makeToCurrencyController {
    CurrencyViewController *currencyController = [self p_instantiateCurrencyController];
    _toCurrencySubModule = currencyController.module;
    _toCurrencySubModule.wallet = _user.wallet;
    _toCurrencySubModule.parentModule = self;
    [_view didMakeToCurrencyController:currencyController];
}

- (void)makeCurrencyRateView {
    
}

#pragma mark - Private methods

- (CurrencyViewController *)p_instantiateCurrencyController {
    UIViewController *controller = [STORYBOARD instantiateViewControllerWithIdentifier:kRevolutCurrencyViewControllerSB_ID];
    CurrencyViewController *currencyController = (CurrencyViewController *)controller;
    return currencyController;
}

@end
