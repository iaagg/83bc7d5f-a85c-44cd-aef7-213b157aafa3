
#import "CurrencyCollectionViewDataManager.h"
#import "CurrencyCollectionViewCell.h"
#import "PONSO_Currency.h"
#import "CurrencyTextFormatter.h"
#import "CurrencyRate.h"
#import "CurrencyExchangeValueChangingDelegate.h"
#import "CurrencyValueTextfieldDelegate.h"

static NSString * const kRevolutCurrencyCollectionViewCellID = @"kRevolutCurrencyCollectionViewCell";

@interface CurrencyCollectionViewDataManager () <CurrencyExchangeValueChangingDelegate>

@property (weak, nonatomic) id<CurrencyCollectionViewDataManagerDelegate>   delegate;
@property (strong, nonatomic) NSArray                                       *dataSource;
@property (strong, nonatomic) NSNumber                                      *exchangeValue;

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

- (void)userChangedExchangeValue:(NSNumber *)newValue {
    _exchangeValue = newValue;
    [self p_reloadCentralSection];
    [self p_focusOnCurrentCurrencyValue];
    [_delegate currencyExchangeValueWasUpdated:newValue];
    [self p_checkForExceedingTheDeposit];
}

#pragma mark - CurrencyCollectionViewDataManagerProtocol

- (void)setRate:(CurrencyRate *)rate {
    _rate = rate;
    [self p_reloadCentralSection];
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
                
                //Making any first cell as first responder to call keyboard
                NSIndexPath *indexOfFirstCell = [NSIndexPath indexPathForRow:0 inSection:0];
                [self p_focusOnCurrencyValueInCellWithIndex:indexOfFirstCell];
                
                //Switching to proper cell
                [self p_switchToPageWithIndexPath:pageIndex];
            }
        }
    }
}

- (void)updateExchangeResultLabelWithValue:(NSNumber *)value {
    NSIndexPath *currentPageIndex = [self p_currentPage];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CurrencyCollectionViewCell *cell = (CurrencyCollectionViewCell *)([_collectionView cellForItemAtIndexPath:currentPageIndex]);
        [cell.value setAttributedText:[self p_exchangeResultValueStringWithValue:value]];
    });
}

- (void)checkIfExchangeValueExceedsTheDeposit {
    [self p_checkForExceedingTheDeposit];
}

- (void)reload {
    _exchangeValue = nil;
    [self p_reloadCentralSection];
    [self p_focusOnCurrentCurrencyValue];
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

- (void)p_checkForExceedingTheDeposit {
    NSIndexPath *currentCurrencyIndex = [self p_currentPage];
    NSArray *currencies = _dataSource[1];
    PONSO_Currency *currentCurrency = currencies[currentCurrencyIndex.item];
    double exchangeValue = [_exchangeValue doubleValue];
    BOOL depositExceeded = [self p_isExchangeLimitExceededFor:currentCurrency withExchangeValue:exchangeValue];
    [_delegate exchangeValueExceedsDeposit:depositExceeded];
}

- (BOOL)p_isExchangeLimitExceededFor:(PONSO_Currency *)currency withExchangeValue:(double)exchangeValue {
    BOOL isExchangeLimitExceeded = currency.amount < exchangeValue;
    return isExchangeLimitExceeded;
}

- (void)p_reloadCentralSection {
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:1];
    [UIView performWithoutAnimation:^{
        [_collectionView reloadSections:set];
    }];
}

- (void)p_handlePageShiftingInScrollView:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.x;
    
    if ([self p_isPageSwitchedWithOffset:offset]) {
        NSIndexPath *indexOfPage = [self p_currentPage];
        [self p_switchToPageWithIndexPath:indexOfPage];
    }
}

- (void)p_switchToPageWithIndexPath:(NSIndexPath *)indexPath {
    [_collectionView scrollToItemAtIndexPath:indexPath
                            atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                    animated:NO];
    
        //In case of carousel shifting cell may be not initialized yet to become first responder
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self p_focusOnCurrencyValueInCellWithIndex:indexPath];
            [_delegate switchedToCurrencyWithIndex:indexPath.item];
            [self p_checkForExceedingTheDeposit];
        });
}

- (void)p_focusOnCurrentCurrencyValue {
    NSIndexPath *currentCurrencyIndex = [self p_currentPage];
    [self p_focusOnCurrencyValueInCellWithIndex:currentCurrencyIndex];
}

- (void)p_focusOnCurrencyValueInCellWithIndex:(NSIndexPath *)indexPath {
    if (_viewType == FromCurrencyType) {
        CurrencyCollectionViewCell *cell = (CurrencyCollectionViewCell *)([_collectionView cellForItemAtIndexPath:indexPath]);
        
        //Avoiding keyboard appearence animation
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.0];
        [UIView setAnimationDelay:0.0];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        
        [cell.value becomeFirstResponder];
        
        [UIView commitAnimations];
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
    double exchangeValue = [_exchangeValue doubleValue];
    BOOL shouldHighlightDeposit = [self p_isExchangeLimitExceededFor:currency withExchangeValue:exchangeValue];
    cell.depositLabel.attributedText = [CurrencyTextFormatter makeDepositStringWithAmount:currency.amount
                                                                                   symbol:currency.symbol
                                                                          shouldHighlight:shouldHighlightDeposit];
    
    //Rate label
    if (_rate) {
        cell.currencyRateLabel.attributedText = [CurrencyTextFormatter makeRateStringWithFromCurrency:_rate.fromCurrency
                                                                                           toCurrency:_rate.toCurrency
                                                                                                 rate:_rate.rate
                                                                                                 from:NO];
    } else {
        cell.currencyRateLabel.text = @"";
    }
    
    //Value textfield
    if (_viewType == ToCurrencyType) {
        cell.value.userInteractionEnabled = NO;
    } else {
        cell.textFieldDelegateStrongReference = [[CurrencyValueTextfieldDelegate alloc] initWithValueChangingDelegate:self];
        cell.value.delegate = cell.textFieldDelegateStrongReference;
        [cell.value setAttributedText:[self p_exchangingValueStringWithValue:_exchangeValue]];
    }
}

- (CGFloat)p_pageWidth {
    return _collectionView.bounds.size.width;
}

//Determines if user dragged scroll view to new page
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
    
    //index of item in central section
    NSInteger pageInCentralSection;
    
    /*  Determining correct page according to carousel effect
        DataSource for collection view has special structure for carousel effect:
     
                          0 section   1 section   2 section
                        [ [0, 1, 2],  [3, 4, 5],  [6, 7, 8] ]
     
    */
    
    //# User dragged to 0 section
    if (carouselPage < numberOfPages) {
        pageInCentralSection = (carouselPage + numberOfPages) % numberOfPages;
        
    //# User dragged inside 1 section
    } else if (carouselPage >= numberOfPages * 2) {
        pageInCentralSection = (carouselPage - numberOfPages) % numberOfPages;
        
    //# User dragged to 2 dection
    } else {
        pageInCentralSection = carouselPage % numberOfPages;
    }
    
    //Doesn't matter in which section is user now -> we always detect the corresponding page in section 1.
    NSIndexPath *page = [NSIndexPath indexPathForRow:pageInCentralSection inSection:1];
    return page;
}

- (NSAttributedString *)p_exchangingValueStringWithValue:(NSNumber *)value {
    
    if (!value) {
        return [[NSAttributedString alloc] initWithString:@""];
    }
    
    NSAttributedString *outputString = [CurrencyTextFormatter makeFromCurrencyValueStringWithValue:value];
    return outputString;
}

- (NSAttributedString *)p_exchangeResultValueStringWithValue:(NSNumber *)value {
    
    if (!value) {
        return [[NSAttributedString alloc] initWithString:@""];
    }
    
    NSAttributedString *outputString = [CurrencyTextFormatter makeToCurrencyValueStringWithValue:value];
    return outputString;
}

@end
