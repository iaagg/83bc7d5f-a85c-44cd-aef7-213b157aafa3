
#import <UIKit/UIKit.h>
#import "CurrencyViewInput.h"
#import "CurrencyViewOutput.h"

@interface CurrencyViewController : UIViewController <CurrencyViewInput>

@property (weak, nonatomic, getter=p_fetchModule) id<CurrencyModuleInput> module;
@property (strong, nonatomic) id<CurrencyViewOutput> output;

@end
