
#import "CurrencyInteractor.h"
#import "PONSO_Wallet.h"
#import "PONSO_Currency.h"

static NSInteger const kRevolutCarouselSectionsCount = 3;

@implementation CurrencyInteractor

- (void)makeDataSourceForCurrencyCollectionViewWithWallet:(PONSO_Wallet *)wallet {
    NSArray *currencies = wallet.currencies;
    NSMutableArray *dataSource = [NSMutableArray array];
    
    for (int i = 0; i < kRevolutCarouselSectionsCount ; i++) {
        dataSource add
    }

}

@end
