
#import <XCTest/XCTest.h>
#import "TestCoreDataStack.h"
#import "Currency+CoreDataClass.h"
#import "NSManagedObject+Creating.h"
#import "PONSO_Currency.h"
#import "PONSO_CurrencyParser.h"

#define TITLE  @"title1"
#define SYMBOL @"symbol1"
#define AMOUNT 500

@interface PONSO_CurrencyParserTest : XCTestCase

@property (weak, nonatomic) TestCoreDataStack *coreDataStack;
@property (strong, nonatomic) Currency *currency;

@end

@implementation PONSO_CurrencyParserTest

- (void)setUp {
    [super setUp];
    _coreDataStack = [TestCoreDataStack shared];
    _currency = [self p_setupDefaultCurrency];
}

- (void)tearDown {
    [super tearDown];
    _currency = nil;
    [_coreDataStack deleteEntities:[Currency class]];
}

- (void)testAllPropertiesParsedToPONSO_Currencies {
    PONSO_Currency *ponsoCurrency = [PONSO_CurrencyParser parseCoreDataCurrency:_currency];
    XCTAssertEqualObjects(ponsoCurrency.title, _currency.title, @"ponsoCurrency title: %@ is NOT equal CoreData currency title: %@", ponsoCurrency.title, _currency.title);
    XCTAssertEqualObjects(ponsoCurrency.symbol, _currency.symbol, @"ponsoCurrency symbol: %@ is NOT equal CoreData currency symbol: %@", ponsoCurrency.symbol, _currency.symbol);
    XCTAssertEqual(ponsoCurrency.amount, _currency.amount, @"ponsoCurrency amount: %f is NOT equal CoreData currency amount: %f", ponsoCurrency.amount, _currency.amount);
}

#pragma mark - SETUP

- (Currency *)p_setupDefaultCurrency {
    NSManagedObjectContext *mainContext = _coreDataStack.mainQueueContext;
    Currency *currency = [Currency createInContext:mainContext];
    [currency setTitle:TITLE];
    [currency setSymbol:SYMBOL];
    [currency setAmount:AMOUNT];
    return currency;
}

@end
