
#import <UIKit/UIKit.h>

@protocol ExchangeViewNotificationsHandlerDelegate <NSObject>

/*!
 * @discussion Handles information about height of keyboard. Called before keyboard is visible.
 * @param height Height of keyboard
 */
- (void)keyboardHeightReceived:(CGFloat)height;

@end
