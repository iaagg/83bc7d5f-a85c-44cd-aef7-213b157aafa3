
#import "ExchangeViewController.h"
#import "ExchangeNotificationsHandlerProtocol.h"
#import "ExchangeNotificationsHandler.h"
#import "UIView+DefaultConstraints.h"

@interface ExchangeViewController ()

@property (strong, nonatomic) id<ExchangeNotificationsHandlerProtocol>  notificationsHandler;
@property (weak, nonatomic) IBOutlet CurrencyRateView                   *currencyRateView;
@property (weak, nonatomic) IBOutlet UIView                             *currencyRateViewContainer;
@property (weak, nonatomic) IBOutlet UIView                             *fromCurrencyContainer;
@property (weak, nonatomic) IBOutlet UIView                             *toCurrencyContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint                 *currenciesContainerBottomConstraint;
@property (weak, nonatomic) IBOutlet UIButton                           *exchangeButton;
@property (weak, nonatomic) IBOutlet UIButton                           *cancelButton;
@property (assign, nonatomic) BOOL                                      exchangeAvailable;

@end

@implementation ExchangeViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //Making keyboard appeared without animations
    [UIView setAnimationsEnabled:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupCurrencyRateView];
    [_output viewIsReady];
}

#pragma mark - ExchangeViewInput

- (void)setupInitialState {
    _notificationsHandler = [[ExchangeNotificationsHandler alloc] initWithDelegate:self];
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
    [self p_enableExchangeButton];
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
        if (_exchangeAvailable) {
            [self p_enableExchangeButton];
        }
    }
}

#pragma mark - ExchangeNotificationHandlerDelegate

- (void)keyboardHeightReceived:(CGFloat)originY {
    _currenciesContainerBottomConstraint.constant = originY;
    [self.view layoutSubviews];
}

#pragma mark - Buttons actions

- (IBAction)performExchange:(id)sender {
    [_output userChoosedToProcceedExchange];
}

#pragma mark - Private methods

- (void)p_setupCurrencyRateView {
    [_currencyRateViewContainer addToMarginsConstraintsForView:_currencyRateView];
}

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
