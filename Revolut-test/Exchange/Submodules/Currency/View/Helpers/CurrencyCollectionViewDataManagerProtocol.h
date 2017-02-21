
#import <UIKit/UIKit.h>
#import "CurrenciesViewTypes.h"
#import "CurrencyCollectionViewDataManagerDelegate.h"

@class CurrencyRate;

@protocol CurrencyCollectionViewDataManagerProtocol <NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) UICollectionView    *collectionView;
@property (strong, nonatomic) CurrencyRate      *rate;
@property (assign, nonatomic) CurrencyViewType  viewType;

- (instancetype)initWithDelegate:(id<CurrencyCollectionViewDataManagerDelegate>)delegate dataSource:(NSArray *)dataSource;

- (void)switchToPageWithIndex:(NSInteger)index;

@end
