
#import <Foundation/Foundation.h>
#import "CurrencyViewInput.h"
#import "CurrencyViewOutput.h"
#import "CurrencyInteractorInput.h"
#import "CurrencyInteractorOutput.h"
#import "CurrencyModuleInput.h"
#import "CurrencyModuleOutput.h"

@interface CurrencyPresenter : NSObject <CurrencyModuleInput, CurrencyViewOutput, CurrencyInteractorOutput>

@property (weak, nonatomic) id<CurrencyViewInput>           view;
@property (strong, nonatomic) id<CurrencyInteractorInput>   interactor;
@property (strong, nonatomic) PONSO_Wallet                  *wallet;
@property (weak, nonatomic) id<CurrencyModuleOutput>        parentModule;

@end
