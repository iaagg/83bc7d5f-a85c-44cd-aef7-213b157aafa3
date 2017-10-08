
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

- (void)viewWillLayoutSubviews {
    [_collectionView.collectionViewLayout invalidateLayout];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    //switching to initial currency page
    [_dataManager switchToPageWithIndex:_currentCurrencyIndex];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //Sets initial exchange value to nil
    [_output currencyExchangeValueWasUpdated:nil];
}

#pragma mark - CurrencyViewInput

- (void)setupInitialStateWithViewType:(CurrencyViewType)viewType currencyIndex:(NSInteger)currencyIndex {
    [self p_setupInterfaceWithViewType:viewType];
    [_output makeDataSourceForCurrencyCollectionView];
    _currentCurrencyIndex = currencyIndex;
    _pageControl.currentPage = _currentCurrencyIndex;
}

- (void)reloadInterfaceAfterSuccessfulExchange {
    [_dataManager reload];
}

- (void)didMakeDataSourceForCurrencyCollectionView:(NSArray *)dataSource {
    [self p_setupCollectionViewWithDataSorce:dataSource];
}

- (void)requestDepositExceedingInfo {
    [_dataManager checkIfExchangeValueExceedsTheDeposit];
}

- (void)updateCurrencyRateLabelWithRate:(CurrencyRate *)currencyRate {
    _dataManager.rate = currencyRate;
}

- (void)updateExchangeResultLabelWithValue:(NSNumber *)value {
    [_dataManager updateExchangeResultLabelWithValue:value];
}

#pragma mark - CurrencyCollectionViewDataManagerDelegate

- (void)switchedToCurrencyWithIndex:(NSInteger)index {
    _currentCurrencyIndex = index;
    _pageControl.currentPage = _currentCurrencyIndex;
    [_output userSwitchedToCurrencyWithIndex:index currencyViewType:_viewType];
}

- (void)currencyExchangeValueWasUpdated:(NSNumber *)newValue {
    [_output currencyExchangeValueWasUpdated:newValue];
}

- (void)exchangeValueExceedsDeposit:(BOOL)valueExceedsDeposit {
    [_output exchangeValueExceedsDeposit:valueExceedsDeposit];
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

- (void)p_setupCollectionViewWithDataSorce:(NSArray *)dataSorce {
    _dataManager = [[CurrencyCollectionViewDataManager alloc] initWithDelegate:self dataSource:dataSorce];
    _dataManager.collectionView = _collectionView;
    _dataManager.viewType = _viewType;
    _collectionView.dataSource = _dataManager;
    _collectionView.delegate = _dataManager;
}

#pragma Used only for "ToCurrencyType" view type

- (void)p_setupToCurrencyInterface {
    
    //Overlay view creation and setup
    UIView *overlay = [[UIView alloc] initWithFrame:self.view.frame];
    overlay.userInteractionEnabled = NO;
    overlay.translatesAutoresizingMaskIntoConstraints = NO;
    overlay.backgroundColor = [[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0.15];
    [self.view addToMarginsConstraintsForView:overlay];
    [CurrencyDrawingHelper cutTriangleFromCurrencyOverlayView:overlay];
}

#pragma VIPER methods

- (id<CurrencyModuleInput>)p_fetchModule {
    __block id<CurrencyModuleInput> module;
    [_output module:^(id<CurrencyModuleInput> fetchedModule) {
        module = fetchedModule;
    }];
    
    return module;
}

@end
