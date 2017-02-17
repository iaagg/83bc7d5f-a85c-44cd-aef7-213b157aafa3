
#import <Foundation/Foundation.h>
#import "CurrencyModuleInput.h"

@protocol CurrencyViewInput <NSObject>

@property (weak, nonatomic, getter=p_fetchModule) id<CurrencyModuleInput> module;

- (void)setupInitialState;
- (void)didMakeDataSourceForCurrencyCollectionView:(NSArray *)dataSource;

@end
