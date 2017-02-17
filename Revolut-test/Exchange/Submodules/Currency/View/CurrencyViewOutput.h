
#import <Foundation/Foundation.h>

@protocol CurrencyViewOutput <NSObject>

- (void)module:(void(^)(id<CurrencyModuleInput>fetchedModule))module;
- (void)viewIsReady;
- (void)makeDataSourceForCurrencyCollectionView;

@end
