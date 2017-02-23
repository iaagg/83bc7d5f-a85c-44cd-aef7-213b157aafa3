
#import <Foundation/Foundation.h>
#import "ExchangeInteractorInput.h"
#import "ExchangeInteractorOutput.h"
#import "ExchangeInteractorNotificationsHandlerDelegate.h"

@interface ExchangeInteractor : NSObject <ExchangeInteractorInput, ExchangeInteractorNotificationsHandlerDelegate>

@property (weak, nonatomic) id<ExchangeInteractorOutput> output;

@end
