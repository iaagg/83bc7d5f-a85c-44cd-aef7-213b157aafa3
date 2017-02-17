
#import "CurrencyPresenter.h"

@implementation CurrencyPresenter

#pragma mark - CurrencyViewOutput

- (void)module:(void (^)(id<CurrencyModuleInput>))module {
    module(self);
}

- (void)viewIsReady {
    [_view setupInitialState];
}

- (void)makeDataSourceForCurrencyCollectionView {
    
}

#pragma mark - CurrencyIntractorOutput

- (void)didMakeDataSourceForCurrencyCollectionView:(NSArray *)dataSource {
    [_view didMakeDataSourceForCurrencyCollectionView:dataSource];
}

@end
