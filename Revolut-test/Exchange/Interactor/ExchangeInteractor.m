#import "ExchangeInteractor.h"
#import "StackFactory.h"
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

static NSString * const kRevolutDefaultUsername = @"defaultRevolutUser";
static NSTimeInterval const kRevolutRatesRequestPeriod = 30;

@interface ExchangeInteractor () <CurrenciesParserDelegate>

@property (weak, nonatomic) id<StackProtocol>               coreDataStack;
@property (strong, nonatomic) id<CurrenciesParserProtocol>  currenciesParser;
@property (weak, nonatomic) NSTimer                         *fetchRatesTimer;

@end

@implementation ExchangeInteractor

- (instancetype)init {
    if (self = [super init]) {
        _coreDataStack = [StackFactory stackForCurrentEnvironment];
        _currenciesParser = [[CurrenciesParser alloc] initWithDelegate:self];
    }
    
    return self;
}

#pragma mark - ExchangeIneractorInput

- (void)startFetchingRatesTask {
    [_output didStartFetchingCurrenciesRates];
    [self p_fetchRatesData];
    _fetchRatesTimer = [NSTimer scheduledTimerWithTimeInterval:kRevolutRatesRequestPeriod target:self selector:@selector(p_fetchRatesData) userInfo:nil repeats:YES];
}

- (void)retryFetchingRates {
    [_fetchRatesTimer invalidate];
    [self startFetchingRatesTask];
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

- (void)makeExchangeFromCurrencyRateFromCurrency:(PONSO_Currency *)fromCurrency
                                      toCurrency:(PONSO_Currency *)toCurrency
                             withCurrenciesRates:(NSArray<NSDictionary *> *)currenciesRates {
    CurrencyRate *rate = [RatesMaker currencyRateFromCurrency:fromCurrency
                                                   toCurrency:toCurrency
                                          withCurrenciesRates:currenciesRates];
    [_output didMakeExchangeFromCurrencyRate:rate];
}

- (void)makeExchangeToCurrencyRateFromCurrency:(PONSO_Currency *)fromCurrency
                                    toCurrency:(PONSO_Currency *)toCurrency
                           withCurrenciesRates:(NSArray<NSDictionary *> *)currenciesRates {
    CurrencyRate *rate = [RatesMaker currencyRateFromCurrency:fromCurrency
                                                   toCurrency:toCurrency
                                          withCurrenciesRates:currenciesRates];
    [_output didMakeExchangeToCurrencyRate:rate];
}

- (void)countValueAfterExchangeFromCurrency:(PONSO_Currency *)fromCurrency
                                 toCurrency:(PONSO_Currency *)toCurrency
                            currenciesRates:(NSArray<NSDictionary *> *)currenciesRates
                            valueToExchange:(NSNumber *)value {
    double valueAfterExchange = [self p_countValueAfterExchangeFromCurrency:fromCurrency
                                                                 toCurrency:toCurrency
                                                            currenciesRates:currenciesRates
                                                            valueToExchange:value];
    [_output didCountValueAfterExchange:[NSNumber numberWithDouble:valueAfterExchange]];
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

#pragma mark - Private methods

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

- (void)p_fetchRatesData {
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
