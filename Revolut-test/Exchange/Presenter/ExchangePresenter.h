
#import <Foundation/Foundation.h>
#import "ExchangeViewOutput.h"
#import "ExchangeInteractorOutput.h"
#import "ExchangeInteractorInput.h"
#import "ExchangeViewInput.h"
#import "CurrencyModuleOutput.h"

@interface ExchangePresenter : NSObject <ExchangeViewOutput, ExchangeInteractorOutput, CurrencyModuleOutput>

@property (weak, nonatomic) id<ExchangeViewInput>           view;
@property (strong, nonatomic) id<ExchangeInteractorInput>   interactor;

- (void)viewIsReady;

@end
