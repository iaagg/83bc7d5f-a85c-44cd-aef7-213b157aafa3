
#import <Foundation/Foundation.h>
#import "ExchangeInteractorInput.h"
#import "ExchangeInteractorOutput.h"

@interface ExchangeInteractor : NSObject <ExchangeInteractorInput>

@property (weak, nonatomic) id<ExchangeInteractorOutput> output;

@end
