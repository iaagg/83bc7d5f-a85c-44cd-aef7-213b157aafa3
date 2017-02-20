
#import "CurrencyViewController.h"
#import "CurrencyCollectionViewDataManager.h"
#import "CurrencyDrawingHelper.h"

@interface CurrencyViewController () <CurrencyCollectionViewDataManagerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView                       *collectionView;
@property (strong, nonatomic) id<CurrencyCollectionViewDataManagerProtocol> dataManager;
@property (assign, nonatomic) CurrencyViewType                              viewType;

@end

@implementation CurrencyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_output viewIsReady];
}

#pragma mark - CurrencyViewInput

- (void)setupInitialStateWithViewType:(CurrencyViewType)viewType {
    [self p_setupInterfaceWithViewType:viewType];
    [_output makeDataSourceForCurrencyCollectionView];
}

- (void)didMakeDataSourceForCurrencyCollectionView:(NSArray *)dataSource {
    [self p_setupCollectionViewWithDataSorce:dataSource];
}

#pragma mark - Private mathods

- (void)p_setupInterfaceWithViewType:(CurrencyViewType)viewType {
    switch (viewType) {
        case ToCurrencyType: {
            [self p_setupToCurrencyInterface];
            break;
        }
        default:
            break;
    }
}

- (void)p_setupToCurrencyInterface {
    UIView *overlay = [[UIView alloc] initWithFrame:self.view.frame];
    overlay.userInteractionEnabled = NO;
    overlay.translatesAutoresizingMaskIntoConstraints = NO;
    overlay.backgroundColor = [[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0.15];
    [self.view addSubview:overlay];
    NSDictionary *views = @{@"overlay" : overlay};
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[overlay]|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[overlay]|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:views]];
    [CurrencyDrawingHelper cutTriangleFromCurrencyOverlayView:overlay];
}

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
