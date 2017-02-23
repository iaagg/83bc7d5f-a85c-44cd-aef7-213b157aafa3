
#import <Foundation/Foundation.h>

@protocol ExchangeInteractorNotificationsHandlerDelegate <NSObject>

/*!
 * @discussion Handles information about collapsing the application.
 */
- (void)applicationWillResignActive;

/*!
 * @discussion Handles information about reopening application.
 */
- (void)applicationDidBecomeActive;

@end
