
#import "CurrencyCollectionViewDataManager.h"
#import "CurrencyCollectionViewCell.h"
#import "PONSO_Currency.h"
#import "CurrencyTextFormatter.h"

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



#pragma mark - UICollectionViewFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.bounds.size;
}

#pragma mark - Private methods

- (void)p_setupCell:(CurrencyCollectionViewCell *)cell withCurrency:(PONSO_Currency *)currency {
    
    //Currency title abbreviation
    cell.currencyTitle.text = currency.title;
    
    //Deposit label
    cell.depositLabel.attributedText = [[CurrencyTextFormatter shared] makeDepositStringWithAmount:currency.amount
                                                                                            symbol:currency.symbol
                                                                                         labelFont:cell.depositLabel.font];
}

@end
