
#import <UIKit/UIKit.h>
#import "ExchangeViewInput.h"
#import "ExchangeViewOutput.h"
#import "ExchangeViewNotificationsHandlerDelegate.h"

@interface ExchangeViewController : UIViewController <ExchangeViewInput, ExchangeViewNotificationsHandlerDelegate>

@property (strong, nonatomic) id<ExchangeViewOutput> output;

@end
