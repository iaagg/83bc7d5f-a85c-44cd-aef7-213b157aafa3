
#import <Foundation/Foundation.h>
#import "ExchangeViewNotificationsHandlerDelegate.h"

@protocol ExchangeViewNotificationsHandlerProtocol <NSObject>

/*!
 * @discussion Initializes object conformed to ExchangeViewNotificationsHandlerProtocol protocol
 * @param delegate object conformed to ExchangeViewNotificationsHandlerDelegate protocol
 */
- (instancetype)initWithDelegate:(id<ExchangeViewNotificationsHandlerDelegate>)delegate;

@end
