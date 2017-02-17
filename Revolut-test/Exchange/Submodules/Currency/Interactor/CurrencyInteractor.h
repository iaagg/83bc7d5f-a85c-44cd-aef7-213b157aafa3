
#import <Foundation/Foundation.h>
#import "CurrencyInteractorInput.h"
#import "CurrencyInteractorOutput.h"

@interface CurrencyInteractor : NSObject <CurrencyInteractorInput>

@property (weak, nonatomic) id<CurrencyInteractorOutput> output;


@end
