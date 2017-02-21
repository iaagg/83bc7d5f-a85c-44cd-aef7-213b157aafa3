
#import "ExchangeViewController.h"
#import "ExchangeNotificationsHandlerProtocol.h"
#import "ExchangeNotificationsHandler.h"

static NSString * const kRevolutCurrenciesRatesUpdatingFailedMessage = @"Error while updating currencies rates. Please, retry or wait for update";
static NSString * const kRevolutRetryUpdateButtonTitle = @"Retry";
static NSString * const kRevolutWaitForUpdateButtonTitle = @"OK";

@interface ExchangeViewController ()

@property (strong, nonatomic) id<ExchangeNotificationsHandlerProtocol>  notificationsHandler;
@property (weak, nonatomic) IBOutlet CurrencyRateView                   *currencyRateView;
@property (weak, nonatomic) IBOutlet UIView                             *currencyRateViewContainer;
@property (weak, nonatomic) IBOutlet UIView                             *fromCurrencyContainer;
@property (weak, nonatomic) IBOutlet UIView                             *toCurrencyContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint                 *toCurrencyContainerBottomConstraint;
@property (weak, nonatomic) IBOutlet UIButton                           *exchangeButton;
@property (weak, nonatomic) IBOutlet UIButton                           *cancelButton;

@end

@implementation ExchangeViewController

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
    [self p_enableExchangeButton];
}

- (void)setUpdatingCurrenciesRatesFailedState {
    [self p_presentUpdatingFailedAlert];
}

- (void)didMakeFromCurrencyController:(UIViewController *)controller {
    [self p_addFromCurrencyController:controller];
}

- (void)didMakeToCurrencyController:(UIViewController *)controller {
    [self p_addToCurrencyController:controller];
}

#pragma mark - ExchangeNotificationHandlerDelegate

- (void)keyboardOriginYReceived:(CGFloat)originY {
    _toCurrencyContainerBottomConstraint.constant = originY;
    [self.view layoutIfNeeded];
}

#pragma mark - Private methods

- (void)p_setupCurrencyRateView {
    [_currencyRateViewContainer addSubview:_currencyRateView];
    [self p_addToMarginsConstraintsFromView:_currencyRateView toView:_currencyRateViewContainer];
}

- (void)p_fetchSubviews {
    [_output makeFromCurrencyController];
    [_output makeToCurrencyController];
}

- (void)p_addFromCurrencyController:(UIViewController *)controller {
    [self p_addToMarginsConstraintsFromView:controller.view toView:_fromCurrencyContainer];
    [self p_addChildViewController:controller];
}

- (void)p_addToCurrencyController:(UIViewController *)controller {
    [self p_addToMarginsConstraintsFromView:controller.view toView:_toCurrencyContainer];
    [self p_addChildViewController:controller];
}

- (void)p_addToMarginsConstraintsFromView:(UIView *)fromView toView:(UIView *)toView {
    [toView addSubview:fromView];
    fromView.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *views = @{@"subview" : fromView};
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[subview]|"
                                                                      options:NSLayoutFormatAlignAllCenterY
                                                                      metrics:nil
                                                                        views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[subview]|"
                                                                      options:NSLayoutFormatAlignAllCenterX
                                                                      metrics:nil
                                                                        views:views]];
}

- (void)p_addChildViewController:(UIViewController *)child {
    [self addChildViewController:child];
    [child didMoveToParentViewController:self];
}

- (void)p_presentUpdatingFailedAlert {
    __weak ExchangeViewController *weakSelf = self;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:kRevolutCurrenciesRatesUpdatingFailedMessage preferredStyle:UIAlertControllerStyleAlert];
    
    //Retry action
    UIAlertAction *retryAction = [UIAlertAction actionWithTitle:kRevolutRetryUpdateButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf.output userChoosedToRetryToUpdateCurrencies];
    }];
    [alert addAction:retryAction];
    
    //OK action
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:kRevolutWaitForUpdateButtonTitle style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:okAction];
    
    //Presenting
    [self presentViewController:alert animated:YES completion:nil];
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
