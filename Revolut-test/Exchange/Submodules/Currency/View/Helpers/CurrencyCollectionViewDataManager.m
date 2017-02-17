
#import "CurrencyCollectionViewDataManager.h"

@interface CurrencyCollectionViewDataManager ()

@property (weak, nonatomic) id<CurrencyCollectionViewDataManagerDelegate>   delegate;
@property (strong, nonatomic) NSArray                                       *dataSource;

@end

@implementation CurrencyCollectionViewDataManager

- (instancetype)initWithDelegate:(id<CurrencyCollectionViewDataManagerDelegate>)delegate dataSource:(NSArray *)dataSource {
    if (self = [super init]) {
        _delegate = delegate;
        _dataSource = dataSource;
    }
    
    return self;
}

@end
