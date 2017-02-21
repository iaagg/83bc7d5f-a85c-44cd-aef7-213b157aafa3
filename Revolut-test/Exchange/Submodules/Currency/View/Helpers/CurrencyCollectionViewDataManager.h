
#import <Foundation/Foundation.h>
#import "CurrencyCollectionViewDataManagerProtocol.h"

@interface CurrencyCollectionViewDataManager : NSObject <CurrencyCollectionViewDataManagerProtocol>

@property (weak, nonatomic) UICollectionView    *collectionView;
@property (strong, nonatomic) CurrencyRate      *rate;
@property (assign, nonatomic) CurrencyViewType  viewType;

- (instancetype)initWithDelegate:(id<CurrencyCollectionViewDataManagerDelegate>)delegate dataSource:(NSArray *)dataSource;

@end
