
#import "CurrencyCollectionViewDataManager.h"
#import "CurrencyCollectionViewCell.h"
#import "PONSO_Currency.h"
#import "CurrencyTextFormatter.h"
#import "CurrencyRate.h"
#import "CurrencyExchangeValueChangingDelegate.h"
#import "CurrencyValueTextfieldDelegate.h"

static NSString * const kRevolutCurrencyCollectionViewCellID = @"kRevolutCurrencyCollectionViewCell";
static NSString * const kRevolutToCurrencyExchangeValuePrefix = @"+ ";

@interface CurrencyCollectionViewDataManager () <CurrencyExchangeValueChangingDelegate>

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

#pragma mark - CurrencyExchangeValueChangingDelegate

- (void)userChangedEchangeValue:(NSNumber *)newValue {
    [_delegate currencyExchangeValueWasUpdated:newValue];
}

#pragma mark - CurrencyCollectionViewDataManagerProtocol

- (void)setRate:(CurrencyRate *)rate {
    _rate = rate;
    [_collectionView reloadData];
}

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

- (void)updateExchangeResultLabelWithValue:(NSNumber *)value {
    NSIndexPath *currentPageIndex = [self p_currentPage];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CurrencyCollectionViewCell *cell = (CurrencyCollectionViewCell *)([_collectionView cellForItemAtIndexPath:currentPageIndex]);
        cell.value.text = [self p_valueStringWithValue:value];
    });
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

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self p_handlePageShiftingInScrollView:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self p_handlePageShiftingInScrollView:scrollView];
}

#pragma mark - UICollectionViewFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.bounds.size;
}

#pragma mark - Private methods

- (void)p_handlePageShiftingInScrollView:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.x;
    
    if ([self p_isPageSwitchedWithOffset:offset]) {
        NSIndexPath *indexOfPage = [self p_currentPage];
        [self p_switchToPageWithIndexPath:indexOfPage];
        
        //In case of carousel shifting cell may be not initialized yet to become first responder
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self p_focusOnCurrencyValueInCellWithIndex:indexOfPage];
            [_delegate switchedToCurrencyWithIndex:indexOfPage.item];
        });
    }
}

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
        cell.textFieldDelegateStrongReference = [[CurrencyValueTextfieldDelegate alloc] initWithValueChangingDelegate:self];
        cell.value.delegate = cell.textFieldDelegateStrongReference;
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

- (NSString *)p_valueStringWithValue:(NSNumber *)value {
    
    if (!value) {
        return @"";
    }
    
    NSString *valueString = [NSString stringWithFormat:@"%.2f", [value doubleValue]];
    NSString *outputString = [NSString stringWithFormat:@"%@%@", kRevolutToCurrencyExchangeValuePrefix, valueString];
    return outputString;
}

@end
