
#import <Foundation/Foundation.h>

@protocol CurrencyInteractorOutput <NSObject>

/*!
 * @discussion Response for presenter with created data source.
 * @param dataSource DataSource array for collection view. 
                    (For carousel behavior, data source has such structure: [
                                                                                [currency1, currency2, currency3],
                                                                                [currency1, currency2, currency3],
                                                                                [currency1, currency2, currency3]
                                                                            ])
 */
- (void)didMakeDataSourceForCurrencyCollectionView:(NSArray *)dataSource;

@end
