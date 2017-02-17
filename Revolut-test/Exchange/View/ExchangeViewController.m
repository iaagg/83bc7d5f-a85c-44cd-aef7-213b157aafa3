
#import "ExchangeViewController.h"
#import "ExchangeNotificationsHandlerProtocol.h"
#import "ExchangeNotificationsHandler.h"

@interface ExchangeViewController ()

@property (strong, nonatomic) id<ExchangeNotificationsHandlerProtocol>  notificationsHandler;
@property (weak, nonatomic) CurrencyRateView                            *currencyRateView;
@property (weak, nonatomic) IBOutlet UIView                             *fromCurrencyContainer;
@property (weak, nonatomic) IBOutlet UIView                             *toCurrencyContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint                 *toCurrencyContainerBottomConstraint;

@end

@implementation ExchangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_output viewIsReady];
}

#pragma mark - ExchangeViewInput

- (void)setupInitialState {
    _notificationsHandler = [[ExchangeNotificationsHandler alloc] initWithDelegate:self];
    [self p_fetchSubviews];
}

- (void)didMakeFromCurrencyController:(UIViewController *)controller {
    [self p_addFromCurrencyController:controller];
}

- (void)didMakeToCurrencyController:(UIViewController *)controller {
    [self p_addToCurrencyController:controller];
}

- (void)didMakeCurrencyRateView:(CurrencyRateView *)currencyRateView {
    [self.navigationItem setTitleView:currencyRateView];
    _currencyRateView = currencyRateView;
}

#pragma mark - ExchangeNotificationHandlerDelegate

- (void)keyboardOriginYReceived:(CGFloat)originY {
    _toCurrencyContainerBottomConstraint.constant = originY;
    [self.view layoutIfNeeded];
}

#pragma mark - Private methods

- (void)p_fetchSubviews {
    [_output makeFromCurrencyController];
    [_output makeToCurrencyController];
    [_output makeCurrencyRateView];
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

@end
