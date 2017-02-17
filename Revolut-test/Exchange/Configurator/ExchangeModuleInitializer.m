
#import "ExchangeModuleInitializer.h"
#import "ExchangeViewController.h"
#import "ExchangeModuleConfigurator.h"

@interface ExchangeModuleInitializer ()

@property (weak, nonatomic) IBOutlet ExchangeViewController *viewController;

@end

@implementation ExchangeModuleInitializer

- (void)awakeFromNib {
    [super awakeFromNib];
    
    ExchangeModuleConfigurator *configurator = [ExchangeModuleConfigurator new];
    [configurator configureModuleForView:_viewController];
}

@end
