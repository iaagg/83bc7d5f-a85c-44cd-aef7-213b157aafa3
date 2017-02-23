
#import <Foundation/Foundation.h>
#import "ExchangeInteractorNotificationsHandlerDelegate.h"

@protocol ExchangeInteractorNotificationsHandlerProtocol <NSObject>

/*!
 * @discussion Initializes object conformed to ExchangeInteractorNotificationsHandlerProtocol protocol
 * @param delegate object conformed to ExchangeInteractorNotificationsHandlerDelegate protocol
 */
- (instancetype)initWithDelegate:(id<ExchangeInteractorNotificationsHandlerDelegate>)delegate;

@end
