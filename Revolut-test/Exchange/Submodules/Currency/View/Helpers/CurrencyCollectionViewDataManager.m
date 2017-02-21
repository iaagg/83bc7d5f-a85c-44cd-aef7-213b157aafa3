
#import "CurrencyCollectionViewDataManager.h"
#import "CurrencyCollectionViewCell.h"
#import "PONSO_Currency.h"
#import "CurrencyTextFormatter.h"
#import "CurrencyRate.h"

static NSString * const kRevolutCurrencyCollectionViewCellID = @"kRevolutCurrencyCollectionViewCell";

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

#pragma mark - CurrencyCollectionViewDataManagerProtocol

- (void)setRate:(CurrencyRate *)rate {
    _rate = rate;
    [_collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *currencies = _dataSource[section];
    return currencies.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _dataSource.count;
}

- (CurrencyCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CurrencyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kRevolutCurrencyCollectionViewCellID
                                                                                 forIndexPath:indexPath];
    NSArray *currencies = _dataSource[indexPath.section];
    PONSO_Currency *currency = currencies[indexPath.row];
    [self p_setupCell:cell withCurrency:currency];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.x;
    
    if ([self p_isPageSwitchedWithOffset:offset]) {
        NSIndexPath *indexOfPage = [self p_currentPage];
        [self p_switchToPageWithIndexPath:indexOfPage];
        [self p_focusOnCurrencyValueInCellWithIndex:indexOfPage];
        [_delegate switchedToCurrencyWithIndex:indexOfPage.item];
    }
}

#pragma mark - UICollectionViewFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.bounds.size;
}

#pragma mark - Navigation

- (void)switchToPageWithIndex:(NSInteger)index {
    
    if (_dataSource) {
        NSIndexPath *pageIndex;
        
        if (index) {
            pageIndex = [NSIndexPath indexPathForItem:index inSection:1];
        } else {
            pageIndex = [NSIndexPath indexPathForItem:0 inSection:1];
        }
        
        if (_dataSource.count > 0) {
            NSArray *currencies = _dataSource[1];
            
            if (currencies.count > pageIndex.item) {
                [self p_switchToPageWithIndexPath:pageIndex];
            }
        }
    }
}

#pragma mark - Private methods

- (void)p_switchToPageWithIndexPath:(NSIndexPath *)indexPath {
    [_collectionView scrollToItemAtIndexPath:indexPath
                            atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                    animated:NO];
    [_delegate switchedToCurrencyWithIndex:indexPath.item];
}

- (void)p_focusOnCurrencyValueInCellWithIndex:(NSIndexPath *)indexPath {
    if (_viewType == FromCurrencyType) {
        CurrencyCollectionViewCell *cell = (CurrencyCollectionViewCell *)([_collectionView cellForItemAtIndexPath:indexPath]);
        [cell.value becomeFirstResponder];
    }
}

- (NSInteger)p_numberOfCurrencies {
    NSArray *currencies =  _dataSource.firstObject;
    return currencies.count;
}

- (void)p_setupCell:(CurrencyCollectionViewCell *)cell withCurrency:(PONSO_Currency *)currency {
    
    //Currency title abbreviation
    cell.currencyTitle.text = currency.title;
    
    //Deposit label
    cell.depositLabel.attributedText = [[CurrencyTextFormatter shared] makeDepositStringWithAmount:currency.amount
                                                                                            symbol:currency.symbol
                                                                                         labelFont:cell.depositLabel.font];
    
    //Rate label
    if (_rate) {
        UIFont *labelFont = cell.currencyRateLabel.font;
        cell.currencyRateLabel.attributedText = [[CurrencyTextFormatter shared] makeRateStringWithFromCurrency:_rate.fromCurrency toCurrency:_rate.toCurrency rate:_rate.rate labelFont:labelFont from:NO];
    }
    
    //Value textfield
    if (_viewType == ToCurrencyType) {
        cell.value.userInteractionEnabled = NO;
    } else {
        [cell.value becomeFirstResponder];
    }
}

- (CGFloat)p_pageWidth {
    return _collectionView.bounds.size.width;
}

- (BOOL)p_isPageSwitchedWithOffset:(CGFloat)offset {
    BOOL switched = false;
    NSInteger intOffset = offset;
    NSInteger intPageWidth = [self p_pageWidth];
    
    if (intOffset % intPageWidth == 0) {
        switched = YES;
    }
    
    return switched;
}

- (NSIndexPath *)p_currentPage {
    NSInteger numberOfPages = [self p_numberOfCurrencies];
    NSInteger carouselPage = _collectionView.contentOffset.x / [self p_pageWidth];
    NSInteger pageInCentralSection;
    
    if (carouselPage < numberOfPages) {
        pageInCentralSection = (carouselPage + numberOfPages) % numberOfPages;
    } else if (carouselPage >= numberOfPages * 2) {
        pageInCentralSection = (carouselPage - numberOfPages) % numberOfPages;
    } else {
        pageInCentralSection = carouselPage % numberOfPages;
    }
    
    NSIndexPath *page = [NSIndexPath indexPathForItem:pageInCentralSection inSection:1];
    return page;
}

@end
