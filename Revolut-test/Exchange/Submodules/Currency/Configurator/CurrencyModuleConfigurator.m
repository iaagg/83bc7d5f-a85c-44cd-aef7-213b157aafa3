
#import "CurrencyModuleConfigurator.h"
#import "CurrencyViewController.h"
#import "CurrencyPresenter.h"
#import "CurrencyInteractor.h"

@implementation CurrencyModuleConfigurator

- (void)configureModuleForView:(UIViewController *)view {
    
    if ([view isKindOfClass:[CurrencyViewController class]]) {
        CurrencyViewController *controller = (CurrencyViewController *)view;
        CurrencyPresenter *presenter = [CurrencyPresenter new];
        CurrencyInteractor *interactor = [CurrencyInteractor new];
        
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
