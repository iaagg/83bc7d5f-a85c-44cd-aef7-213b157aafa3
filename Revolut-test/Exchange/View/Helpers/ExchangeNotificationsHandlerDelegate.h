
#import <UIKit/UIKit.h>

@protocol ExchangeNotificationsHandlerDelegate <NSObject>

- (void)keyboardHeightReceived:(CGFloat)originY;

@end
