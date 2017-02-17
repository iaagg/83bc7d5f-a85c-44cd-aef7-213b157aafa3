#import "ExchangeInteractor.h"
#import "StackFactory.h"
#import "NSManagedObject+Creating.h"
#import "User+FetchRequests.h"
#import "Wallet+CoreDataClass.h"
#import "Currency+CoreDataClass.h"
#import "CurrenciesParser.h"

#define SYM = @"symbol"
#define ABBR = @"abbreviation"

#define EUR [NSString stringWithFormat:@"%C", 0x20ac]
#define USD [NSString stringWithFormat:@"%C", 0x24]
#define GBP [NSString stringWithFormat:@"%C", 0xa3]

#define DEFAULT_CURRENCIES  @[@{ABBR : @"EUR", SYM : EUR}, @{ABBR : @"USD", SYM : USD}, @{ABBR : @"GBP", SYM : GBP}]

static NSString * const kRevolutDefaultUsername = @"defaultRevolutUser";
static NSInteger const kRevolutDefaultStartAmount = 100;

@interface ExchangeInteractor ()

@property (weak, nonatomic) id<StackProtocol> coreDataStack;

@end

@implementation ExchangeInteractor

- (instancetype)init {
    if (self = [super init]) {
        _coreDataStack = [StackFactory stackForCurrentEnvironment];
    }
    
    return self;
}

- (void)fetchDefaultUser {
    User *defaultUser = [User findByName:kRevolutDefaultUsername inContext:_coreDataStack.mainQueueContext];
    
    if (!defaultUser) {
        defaultUser = [self p_setupDefaultUser];
    }
    
}

#pragma mark - Private methods

- (User *)p_setupDefaultUser {
    NSManagedObjectContext *mainContext = _coreDataStack.mainQueueContext;
    User *defaultUser = [User createInContext:mainContext];
    [defaultUser setWallet:[self p_setupDefaultWallet]];
    [defaultUser setUsername:kRevolutDefaultUsername];
    [_coreDataStack saveMainContext];
    return defaultUser;
}

- (Wallet *)p_setupDefaultWallet {
    NSManagedObjectContext *mainContext = _coreDataStack.mainQueueContext;
    Wallet *wallet = [Wallet createInContext:mainContext];
    return wallet;
}

- (NSArray<Currency *> *)p_setupDefaultCurrencies {
    NSArray *currencies = [CurrenciesParser parseSeedCurrencies];
    return currencies;
}

@end
