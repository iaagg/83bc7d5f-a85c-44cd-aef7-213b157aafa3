
#import <UIKit/UIKit.h>
#import "CurrenciesViewTypes.h"
#import "CurrencyCollectionViewDataManagerDelegate.h"

@class CurrencyRate;

@protocol CurrencyCollectionViewDataManagerProtocol <NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

/*! @brief weak reference to it's collection view */
@property (weak, nonatomic) UICollectionView    *collectionView;

/*! @brief rate for currency which would be received after conversion. Works through it's setter. */
@property (strong, nonatomic, setter=setRate:) CurrencyRate      *rate;

/*! @brief determins the typer of CurrencyViewController 
           (if viewType == FromCurrencyType -> 'rate' property should always be nil) */
@property (assign, nonatomic) CurrencyViewType  viewType;

/*!
 * @discussion Initializes object conforming CurrencyCollectionViewDataManagerProtocol protocol.
 * @param delegate Object conforming CurrencyCollectionViewDataManagerDelegate protocol.
 * @param dataSource Crafted date source for collection view.
 * @return Object conforming CurrencyCollectionViewDataManagerProtocol protocol
 */
- (instancetype)initWithDelegate:(id<CurrencyCollectionViewDataManagerDelegate>)delegate dataSource:(NSArray *)dataSource;

/*!
 * @discussion Switches to collection particular view page.
 * @param index Index of currency which page should be presented.
 */
- (void)switchToPageWithIndex:(NSInteger)index;

/*!
 * @discussion Updates displaying amount of currency which would be received after exchange.
 * @param value Amount of currency which would be received after exchange.
 */
- (void)updateExchangeResultLabelWithValue:(NSNumber *)value;

/*!
 * @discussion Performs checking for exceeding the deposit.
 */
- (void)checkIfExchangeValueExceedsTheDeposit;

/*!
 * @discussion Reloads collection view with following focusing on currency to exchange.
 */
- (void)reload;

@end
