
#import "ExchangeModuleConfigurator.h"
#import "ExchangeViewController.h"
#import "ExchangePresenter.h"
#import "ExchangeInteractor.h"

@implementation ExchangeModuleConfigurator

- (void)configureModuleForView:(UIViewController *)view {
    
    if ([view isKindOfClass:[ExchangeViewController class]]) {
        ExchangeViewController *controller = (ExchangeViewController *)view;
        ExchangePresenter *presenter = [ExchangePresenter new];
        ExchangeInteractor *interactor = [ExchangeInteractor new];
        
        //View
        controller.output = presenter;
        
        //Presenter
        presenter.view = controller;
        presenter.interactor = interactor;
        
        //Interactor
        interactor.output = presenter;
    }
    
}

@end
