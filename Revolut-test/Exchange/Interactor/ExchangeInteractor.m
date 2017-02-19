#import "ExchangeInteractor.h"
#import "StackFactory.h"
#import "NSManagedObject+Creating.h"
#import "User+FetchRequests.h"
#import "Wallet+CoreDataClass.h"
#import "Currency+CoreDataClass.h"
#import "CurrenciesParser.h"
#import "PONSO_User.h"
#import "PONSO_UserParser.h"
#import "UserSaver.h"

static NSString * const kRevolutDefaultUsername = @"defaultRevolutUser";

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
    
    [self p_parseCoreDataUserModel:defaultUser];
}

- (void)savePonsoUser:(PONSO_User *)ponsoUser {
    NSManagedObjectContext *bgContext = [_coreDataStack makeBackgroundContext];
    User *user = [User findByUUID:ponsoUser.uuid inContext:bgContext];
    NSAssert(user == nil, @"Fatal error: user with uuid: %@ wasn't found in db", ponsoUser.uuid);
    
    [UserSaver savePonsoUser:ponsoUser toCoreDataUser:user inBgContext:bgContext];

}

#pragma mark - Private methods

- (void)p_parseCoreDataUserModel:(User *)user {
    PONSO_User *ponsoUser = [PONSO_UserParser parseCoreDataUser:user];
    [_output didFetchDefaultUser:ponsoUser];
}

- (User *)p_setupDefaultUser {
    NSManagedObjectContext *mainContext = _coreDataStack.mainQueueContext;
    User *defaultUser = [User createInContext:mainContext];
    [defaultUser setWallet:[self p_setupDefaultWallet]];
    [defaultUser setUsername:kRevolutDefaultUsername];
    [defaultUser setUuid:[NSUUID UUID].UUIDString];
    [_coreDataStack saveMainContext];
    return defaultUser;
}

- (Wallet *)p_setupDefaultWallet {
    NSManagedObjectContext *mainContext = _coreDataStack.mainQueueContext;
    Wallet *wallet = [Wallet createInContext:mainContext];
    NSOrderedSet<Currency *> *currencies = [self p_setupDefaultCurrencies];
    [wallet setCurrencies:currencies];
    return wallet;
}

- (NSOrderedSet<Currency *> *)p_setupDefaultCurrencies {
    NSArray *currencies = [CurrenciesParser parseSeedCurrencies];
    NSOrderedSet<Currency *> *currenciesSet = [NSOrderedSet orderedSetWithArray:currencies];
    return currenciesSet;
}

@end
