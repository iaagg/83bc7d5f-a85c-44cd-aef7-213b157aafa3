
#import <UIKit/UIKit.h>
#import "CurrencyCollectionViewDataManagerDelegate.h"

@protocol CurrencyCollectionViewDataManagerProtocol <NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) UICollectionView *collectionView;

- (instancetype)initWithDelegate:(id<CurrencyCollectionViewDataManagerDelegate>)delegate dataSource:(NSArray *)dataSource;

- (void)switchToPageWithIndex:(NSInteger)index;

@end
