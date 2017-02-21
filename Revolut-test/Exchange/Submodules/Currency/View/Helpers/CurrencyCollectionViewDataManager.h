
#import <Foundation/Foundation.h>
#import "CurrencyCollectionViewDataManagerProtocol.h"

@interface CurrencyCollectionViewDataManager : NSObject <CurrencyCollectionViewDataManagerProtocol>

@property (weak, nonatomic) UICollectionView *collectionView;

- (instancetype)initWithDelegate:(id<CurrencyCollectionViewDataManagerDelegate>)delegate dataSource:(NSArray *)dataSource;

@end
