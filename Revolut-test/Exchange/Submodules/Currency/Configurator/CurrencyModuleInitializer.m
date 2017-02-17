
#import "CurrencyModuleInitializer.h"
#import "CurrencyViewController.h"
#import "CurrencyModuleConfigurator.h"

@interface CurrencyModuleInitializer ()

@property (weak, nonatomic) IBOutlet CurrencyViewController *viewController;

@end

@implementation CurrencyModuleInitializer

- (void)awakeFromNib {
    [super awakeFromNib];
    
    CurrencyModuleConfigurator *configurator = [CurrencyModuleConfigurator new];
    [configurator configureModuleForView:_viewController];
}

@end
