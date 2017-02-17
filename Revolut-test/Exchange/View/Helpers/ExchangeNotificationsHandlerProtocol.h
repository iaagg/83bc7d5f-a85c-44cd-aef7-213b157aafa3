
#import <Foundation/Foundation.h>
#import "ExchangeNotificationsHandlerDelegate.h"

@protocol ExchangeNotificationsHandlerProtocol <NSObject>

- (instancetype)initWithDelegate:(id<ExchangeNotificationsHandlerDelegate>)delegate;

@end
