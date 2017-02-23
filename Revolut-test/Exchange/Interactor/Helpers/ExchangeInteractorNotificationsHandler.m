
#import "ExchangeInteractorNotificationsHandler.h"
#import "ExchangeInteractorNotificationsHandlerDelegate.h"

@interface ExchangeInteractorNotificationsHandler ()

@property (weak, nonatomic) id<ExchangeInteractorNotificationsHandlerDelegate> delegate;

@end

@implementation ExchangeInteractorNotificationsHandler

- (instancetype)initWithDelegate:(id<ExchangeInteractorNotificationsHandlerDelegate>)delegate {
    if (self = [super init]) {
        _delegate = delegate;
        [self p_registerObservers];
    }
    
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Private methods

- (void)p_registerObservers {
    [self p_registerSelector:@selector(p_applicationWillResignActive) forNotificationName:kRevolutAppWillResignActive];
    [self p_registerSelector:@selector(p_applicationDidBecomeActive) forNotificationName:kRevolutAppDidBecomeActive];
}

- (void)p_registerSelector:(SEL)selector forNotificationName:(NSNotificationName)notificationName {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:selector name:notificationName object:nil];
}

- (void)p_applicationWillResignActive {
    [_delegate applicationWillResignActive];
}

- (void)p_applicationDidBecomeActive {
    [_delegate applicationDidBecomeActive];
}

@end
