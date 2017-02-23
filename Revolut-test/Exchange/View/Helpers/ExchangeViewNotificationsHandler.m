
#import "ExchangeViewNotificationsHandler.h"

@interface ExchangeViewNotificationsHandler ()

@property (weak, nonatomic) id<ExchangeViewNotificationsHandlerDelegate> delegate;

@end

@implementation ExchangeViewNotificationsHandler

- (instancetype)initWithDelegate:(id<ExchangeViewNotificationsHandlerDelegate>)delegate {
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
    [self p_registerSelector:@selector(p_keyboardDidShowNotificationReceived:) forNotificationName:UIKeyboardWillShowNotification];
}

- (void)p_registerSelector:(SEL)selector forNotificationName:(NSNotificationName)notificationName {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:selector name:notificationName object:nil];
}

- (void)p_keyboardDidShowNotificationReceived:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    
    if (userInfo) {
        NSValue *keyboardFrameValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
        CGRect keyboardFrame = [keyboardFrameValue CGRectValue];
        CGFloat height = keyboardFrame.size.height;
        [_delegate keyboardHeightReceived:height];
    }
}

@end
