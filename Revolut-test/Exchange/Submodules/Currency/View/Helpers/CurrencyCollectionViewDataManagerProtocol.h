
#import <UIKit/UIKit.h>
#import "CurrencyCollectionViewDataManagerDelegate.h"

@protocol CurrencyCollectionViewDataManagerProtocol <NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

- (instancetype)initWithDelegate:(id<CurrencyCollectionViewDataManagerDelegate>)delegate dataSource:(NSArray *)dataSource;

@end
