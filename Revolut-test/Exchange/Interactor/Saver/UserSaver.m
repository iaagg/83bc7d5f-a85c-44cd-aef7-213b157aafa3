
#import "UserSaver.h"
#import "PONSO_User.h"
#import "PONSO_Wallet.h"
#import "PONSO_Currency.h"
#import "User+CoreDataClass.h"
#import "Wallet+CoreDataClass.h"
#import "Currency+CoreDataClass.h"

@implementation UserSaver

+ (void)savePonsoUser:(PONSO_User *)ponsoUser toCoreDataUser:(User *)user inBgContext:(NSManagedObjectContext *)context {
    NSArray *ponsoCurrencies = ponsoUser.wallet.currencies;
    
    for (PONSO_Currency *ponsoCurrency in ponsoCurrencies) {
        Currency *currency = [UserSaver p_currencyWithName:ponsoCurrency.title inCurrencies:user.wallet.currencies];
        
        if (currency) {
            currency.amount = ponsoCurrency.amount;
        }
    }
    
    [CORE_DATA_STACK saveBackgroundContext:context];
}

#pragma mark - Private methods

+ (Currency *)p_currencyWithName:(NSString *)name inCurrencies:(NSOrderedSet<Currency *> *)currencies {
    NSPredicate *namePredicate = [NSPredicate predicateWithFormat:@"title = %@", name];
    NSOrderedSet *filteredCurrencies = [currencies filteredOrderedSetUsingPredicate:namePredicate];
    
    if (filteredCurrencies.count > 0) {
        return filteredCurrencies.firstObject;
    } else {
        return nil;
    }
}

@end
