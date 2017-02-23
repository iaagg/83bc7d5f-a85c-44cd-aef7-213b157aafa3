
#import "ExchangeViewController.h"
#import "ExchangeViewNotificationsHandlerProtocol.h"
#import "ExchangeViewNotificationsHandler.h"
#import "UIView+DefaultConstraints.h"

@interface ExchangeViewController ()

@property (weak, nonatomic) IBOutlet CurrencyRateView                   *currencyRateView;
@property (weak, nonatomic) IBOutlet UIView                             *currencyRateViewContainer;
@property (weak, nonatomic) IBOutlet UIView                             *fromCurrencyContainer;
@property (weak, nonatomic) IBOutlet UIView                             *toCurrencyContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint                 *currenciesContainerBottomConstraint;
@property (weak, nonatomic) IBOutlet UIButton                           *exchangeButton;
@property (weak, nonatomic) IBOutlet UIButton                           *cancelButton;

/*! @brief strong reference to object conforming to ExchangeNotificationsHandlerProtocol protocol */
@property (strong, nonatomic) id<ExchangeViewNotificationsHandlerProtocol>  notificationsHandler;

/*! @brief Determines possibility of exchanging according to rates up to date state */
@property (assign, nonatomic) BOOL                                      exchangeAvailable;

@end

@implementation ExchangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupCurrencyRateView];
    [_output viewIsReady];
}

#pragma mark - ExchangeViewInput

- (void)setupInitialState {
    _notificationsHandler = [[ExchangeViewNotificationsHandler alloc] initWithDelegate:self];
    [self p_fetchSubviews];
    [self p_disableCancelButton];
}

- (void)setUpdatingCurrenciesRatesState {
    [_currencyRateView setUpdatingState];
    [self p_disableExchangeButton];
}

- (void)setUpdatedCurrenciesRatesStateWith:(CurrencyRate *)rate {
    [_currencyRateView updateRateWithCurrencyRate:rate];
    _exchangeAvailable = YES;
}

- (void)setUpdatingCurrenciesRatesFailedState {
    _exchangeAvailable = NO;
    [self p_disableExchangeButton];
}

- (void)didMakeFromCurrencyController:(UIViewController *)controller {
    [self p_addFromCurrencyController:controller];
}

- (void)didMakeToCurrencyController:(UIViewController *)controller {
    [self p_addToCurrencyController:controller];
}

- (void)exchangeValueExceedsDeposit:(BOOL)valueExceedsDeposit {
    if (valueExceedsDeposit) {
        [self p_disableExchangeButton];
    } else {
        
        //if currencies rates in up to date state -> enable exchange
        if (_exchangeAvailable) {
            [self p_enableExchangeButton];
        }
    }
}

- (void)noValueToExchange {
    [self p_disableExchangeButton];
}

#pragma mark - ExchangeNotificationHandlerDelegate

- (void)keyboardHeightReceived:(CGFloat)height {
    
    //Bringing currencies controllers above keyboard
    _currenciesContainerBottomConstraint.constant = height;
    [self.view layoutSubviews];
}

- (void)applicationWillResignActive {
    
}

- (void)applicationDidBecomeActive {
    
}

#pragma mark - Buttons actions

- (IBAction)performExchange:(id)sender {
    [_output userChoosedToProcceedExchange];
}

#pragma mark - Private methods

- (void)p_setupCurrencyRateView {
    [_currencyRateViewContainer addToMarginsConstraintsForView:_currencyRateView];
}

//Asking presenter to create currency view controllers
- (void)p_fetchSubviews {
    [_output makeFromCurrencyController];
    [_output makeToCurrencyController];
}

- (void)p_addFromCurrencyController:(UIViewController *)controller {
    [_fromCurrencyContainer addToMarginsConstraintsForView:controller.view];
    [self p_addChildViewController:controller];
}

- (void)p_addToCurrencyController:(UIViewController *)controller {
    [_toCurrencyContainer addToMarginsConstraintsForView:controller.view];
    [self p_addChildViewController:controller];
}

- (void)p_addChildViewController:(UIViewController *)child {
    [self addChildViewController:child];
    [child didMoveToParentViewController:self];
}

- (void)p_disableExchangeButton {
    _exchangeButton.alpha = 0.5;
    _exchangeButton.enabled = NO;
    _exchangeButton.userInteractionEnabled = NO;
}

- (void)p_enableExchangeButton {
    _exchangeButton.alpha = 1.0;
    _exchangeButton.enabled = YES;
    _exchangeButton.userInteractionEnabled = YES;
}

- (void)p_disableCancelButton {
    _cancelButton.alpha = 0.5;
    _cancelButton.enabled = NO;
    _cancelButton.userInteractionEnabled = NO;
}

@end
