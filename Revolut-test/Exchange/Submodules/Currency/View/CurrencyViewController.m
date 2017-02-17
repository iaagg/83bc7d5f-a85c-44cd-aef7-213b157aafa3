
#import "CurrencyViewController.h"
#import "CurrencyCollectionViewDataManager.h"

@interface CurrencyViewController () <CurrencyCollectionViewDataManagerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView                       *collectionView;
@property (strong, nonatomic) id<CurrencyCollectionViewDataManagerProtocol> dataManager;

@end

@implementation CurrencyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_output viewIsReady];
}

#pragma mark - CurrencyViewInput

- (void)setupInitialState {
    [_output makeDataSourceForCurrencyCollectionView];
}

- (void)didMakeDataSourceForCurrencyCollectionView:(NSArray *)dataSource {
    [self p_setupCollectionViewWithDataSorce:dataSource];
}

#pragma mark - Private mathods

- (id<CurrencyModuleInput>)p_fetchModule {
    __block id<CurrencyModuleInput> module;
    [_output module:^(id<CurrencyModuleInput> fetchedModule) {
        module = fetchedModule;
    }];
     
    return module;
}

- (void)p_setupCollectionViewWithDataSorce:(NSArray *)dataSorce {
    _dataManager = [[CurrencyCollectionViewDataManager alloc] initWithDelegate:self dataSource:dataSorce];
    _collectionView.dataSource = _dataManager;
    _collectionView.delegate = _dataManager;
}

@end
