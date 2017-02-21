
#import "CurrencyViewController.h"
#import "CurrencyCollectionViewDataManager.h"
#import "CurrencyDrawingHelper.h"

@interface CurrencyViewController () <CurrencyCollectionViewDataManagerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView                       *collectionView;
@property (weak, nonatomic) IBOutlet UIPageControl                          *pageControl;
@property (strong, nonatomic) id<CurrencyCollectionViewDataManagerProtocol> dataManager;
@property (assign, nonatomic) CurrencyViewType                              viewType;
@property (assign, nonatomic) NSInteger                                     currentCurrencyIndex;

@end

@implementation CurrencyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_output viewIsReady];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [_collectionView layoutSubviews];
    [_dataManager switchToPageWithIndex:_currentCurrencyIndex];
}

#pragma mark - CurrencyViewInput

- (void)setupInitialStateWithViewType:(CurrencyViewType)viewType currencyIndex:(NSInteger)currencyIndex {
    [self p_setupInterfaceWithViewType:viewType];
    [_output makeDataSourceForCurrencyCollectionView];
    _currentCurrencyIndex = currencyIndex;
    _pageControl.currentPage = _currentCurrencyIndex;
}

- (void)didMakeDataSourceForCurrencyCollectionView:(NSArray *)dataSource {
    [self p_setupCollectionViewWithDataSorce:dataSource];
}

- (void)updateCurrencyRateLabelWithRate:(CurrencyRate *)currencyRate {
    _dataManager.rate = currencyRate;
}

#pragma mark - CurrencyCollectionViewDataManagerDelegate

- (void)switchedToCurrencyWithIndex:(NSInteger)index {
    _currentCurrencyIndex = index;
    _pageControl.currentPage = _currentCurrencyIndex;
    [_output userSwitchedToCurrencyWithIndex:index currencyViewType:_viewType];
}

#pragma mark - Private mathods

- (void)p_setupInterfaceWithViewType:(CurrencyViewType)viewType {
    _viewType = viewType;
    
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
    
    //Overlay
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
    _dataManager.collectionView = _collectionView;
    _dataManager.viewType = _viewType;
    _collectionView.dataSource = _dataManager;
    _collectionView.delegate = _dataManager;
}

@end
