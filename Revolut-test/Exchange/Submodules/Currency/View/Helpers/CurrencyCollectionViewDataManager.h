
#import <Foundation/Foundation.h>
#import "CurrencyCollectionViewDataManagerProtocol.h"

@interface CurrencyCollectionViewDataManager : NSObject <CurrencyCollectionViewDataManagerProtocol>

- (instancetype)initWithDelegate:(id<CurrencyCollectionViewDataManagerDelegate>)delegate dataSource:(NSArray *)dataSource;

@end
