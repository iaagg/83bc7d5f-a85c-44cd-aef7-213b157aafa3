
#import <UIKit/UIKit.h>
#import "ExchangeViewInput.h"
#import "ExchangeViewOutput.h"
#import "ExchangeNotificationsHandlerDelegate.h"

@interface ExchangeViewController : UIViewController <ExchangeViewInput, ExchangeNotificationsHandlerDelegate>

@property (strong, nonatomic) id<ExchangeViewOutput> output;

- (void)setupInitialState;

@end
