#import "ExchangeInteractor.h"
#import "NSManagedObject+Creating.h"
#import "User+FetchRequests.h"
#import "Wallet+CoreDataClass.h"
#import "Currency+CoreDataClass.h"
#import "CurrenciesParser.h"
#import "PONSO_User.h"
#import "PONSO_UserParser.h"
#import "PONSO_Currency.h"
#import "UserSaver.h"
#import "NetworkClient.h"
#import "RatesMaker.h"
#import "CurrencyRate.h"
#import "ExchangeInteractorNotificationsHandlerProtocol.h"
#import "ExchangeInteractorNotificationsHandler.h"

static NSString * const kRevolutDefaultUsername = @"defaultRevolutUser";
static NSTimeInterval const kRevolutRatesRequestPeriod = 30;

@interface ExchangeInteractor () <CurrenciesParserDelegate>

@property (weak, nonatomic) id<StackProtocol>                                       coreDataStack;
@property (strong, nonatomic) id<CurrenciesParserProtocol>                          currenciesParser;
@property (weak, nonatomic) NSTimer                                                 *fetchRatesTimer;

/*! @brief strong reference to object conforming to ExchangeInteractorNotificationsHandlerProtocol protocol */
@property (strong, nonatomic) id<ExchangeInteractorNotificationsHandlerProtocol>    notificationsHandler;

@end

@implementation ExchangeInteractor

- (instancetype)init {
    if (self = [super init]) {
        _coreDataStack = CORE_DATA_STACK;
        _currenciesParser = [[CurrenciesParser alloc] initWithDelegate:self];
        _notificationsHandler = [[ExchangeInteractorNotificationsHandler alloc] initWithDelegate:self];
    }
    
    return self;
}

- (void)dealloc {
    [_fetchRatesTimer invalidate];
}

#pragma mark - ExchangeIneractorInput

- (void)startFetchingRatesTask {
    if (!_fetchRatesTimer) {
        [self p_fetchRatesData];
        _fetchRatesTimer = [NSTimer scheduledTimerWithTimeInterval:kRevolutRatesRequestPeriod target:self selector:@selector(p_fetchRatesData) userInfo:nil repeats:YES];
    }
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
    NSAssert(user != nil, @"Fatal error: user with uuid: %@ wasn't found in db", ponsoUser.uuid);
    
    [UserSaver savePonsoUser:ponsoUser toCoreDataUser:user inBgContext:bgContext];
}

- (void)makeExchangingFromCurrencyRateFromCurrency:(PONSO_Currency *)fromCurrency
                                      toCurrency:(PONSO_Currency *)toCurrency
                             withCurrenciesRates:(NSArray<NSDictionary *> *)currenciesRates {
    CurrencyRate *rate = [RatesMaker currencyRateFromCurrency:fromCurrency
                                                   toCurrency:toCurrency
                                          withCurrenciesRates:currenciesRates];
    [_output didMakeExchangingFromCurrencyRate:rate];
}

- (void)makeExchangingToCurrencyRateFromCurrency:(PONSO_Currency *)fromCurrency
                                    toCurrency:(PONSO_Currency *)toCurrency
                           withCurrenciesRates:(NSArray<NSDictionary *> *)currenciesRates {
    CurrencyRate *rate = [RatesMaker currencyRateFromCurrency:fromCurrency
                                                   toCurrency:toCurrency
                                          withCurrenciesRates:currenciesRates];
    [_output didMakeExchangingToCurrencyRate:rate];
}

- (void)countValueAfterExchangeFromCurrency:(PONSO_Currency *)fromCurrency
                                 toCurrency:(PONSO_Currency *)toCurrency
                            currenciesRates:(NSArray<NSDictionary *> *)currenciesRates
                            valueToExchange:(NSNumber *)value {
    if (currenciesRates) {
        double valueAfterExchange = [self p_countValueAfterExchangeFromCurrency:fromCurrency
                                                                     toCurrency:toCurrency
                                                                currenciesRates:currenciesRates
                                                                valueToExchange:value];
        [_output didCountValueAfterExchange:[NSNumber numberWithDouble:valueAfterExchange]];
    } else {
        [_output didCountValueAfterExchange:nil];
    }
}

- (void)proceedExchangeFromCurrency:(PONSO_Currency *)fromCurrency
                         toCurrency:(PONSO_Currency *)toCurrency
                    currenciesRates:(NSArray<NSDictionary *> *)currenciesRates
                    valueToExchange:(NSNumber *)value {
    double valueAfterExchange = [self p_countValueAfterExchangeFromCurrency:fromCurrency
                                                                 toCurrency:toCurrency
                                                            currenciesRates:currenciesRates
                                                            valueToExchange:value];
    fromCurrency.amount -= [value doubleValue];
    toCurrency.amount += valueAfterExchange;
    [_output didFinishExchange];
}

#pragma mark - CurrenciesParserDelegate

- (void)parserDidParseCurrenciesRates:(NSArray<NSDictionary *> *)currenciesRates {
    [_output didFetchCurrenciesRates:currenciesRates];
    [_output didFinishFetchingCurrenciesRates];
}

- (void)errorOccuredWhileParsing {
    [_output didFailedFetchingCurrenciesRates];
}

#pragma mark - ExchangeInteractorNotificationsHandlerDelegate

- (void)applicationWillResignActive {
    [self p_stopFetchingRatesTask];
}

- (void)applicationDidBecomeActive {
    [self startFetchingRatesTask];
}

#pragma mark - Private methods

- (void)p_stopFetchingRatesTask {
    [_fetchRatesTimer invalidate];
    _fetchRatesTimer = nil;
}

- (double)p_countValueAfterExchangeFromCurrency:(PONSO_Currency *)fromCurrency
                                     toCurrency:(PONSO_Currency *)toCurrency
                                currenciesRates:(NSArray<NSDictionary *> *)currenciesRates
                                valueToExchange:(NSNumber *)value {
    CurrencyRate *rate = [RatesMaker currencyRateFromCurrency:fromCurrency
                                                   toCurrency:toCurrency
                                          withCurrenciesRates:currenciesRates];
    double valueAsDouble = [value doubleValue];
    double outputValueAsDouble = valueAsDouble * rate.rate;
    return outputValueAsDouble;
}

//Currencies rates network request
- (void)p_fetchRatesData {
    [_output didStartFetchingCurrenciesRates];
    
    [[NetworkClient shared] requestCurrenciesWithSuccess:^(NSData *response) {
        [_currenciesParser parseXMLWithData:response];
    } failureHandler:^(NSError *error) {
        [_output didFailedFetchingCurrenciesRates];
    }];
}

- (void)p_parseCoreDataUserModel:(User *)user {
    PONSO_User *ponsoUser = [PONSO_UserParser parseCoreDataUser:user];
    [_output didFetchDefaultUser:ponsoUser];
}

#pragma Creation of default user 

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
