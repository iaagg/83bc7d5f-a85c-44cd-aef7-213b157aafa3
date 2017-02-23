
#import <XCTest/XCTest.h>
#import "TestCoreDataStack.h"
#import "Wallet+CoreDataClass.h"
#import "Currency+CoreDataClass.h"
#import "NSManagedObject+Creating.h"
#import "PONSO_Wallet.h"
#import "PONSO_WalletParser.h"
#import "PONSO_Currency.h"

@interface PONSO_WalletParserTests : XCTestCase

@property (weak, nonatomic) TestCoreDataStack *coreDataStack;
@property (strong, nonatomic) Wallet *wallet;

@end

@implementation PONSO_WalletParserTests

- (void)setUp {
    [super setUp];
    _coreDataStack = [TestCoreDataStack shared];
    _wallet = [self p_setupDefaultWallet];
}

- (void)tearDown {
    [super tearDown];
    _wallet = nil;
    [_coreDataStack deleteEntities:[Wallet class]];
}

- (void)testAllPropertiesParsedToPONSO_Wallet {
    PONSO_Wallet *ponsoWallet = [PONSO_WalletParser parseCoreDataWallet:_wallet];
    XCTAssertNotNil(ponsoWallet.currencies, @"ponsoWallet doesn't have parsed currencies");
    XCTAssertEqual(ponsoWallet.currencies.count, _wallet.currencies.count, @"Count of currencies in ponsoWallet: %ld and count of currencies in CoreData wallet: %ld", ponsoWallet.currencies.count, _wallet.currencies.count);
}

#pragma mark - SETUP

- (Wallet *)p_setupDefaultWallet {
    NSManagedObjectContext *mainContext = _coreDataStack.mainQueueContext;
    Wallet *wallet = [Wallet createInContext:mainContext];
    NSOrderedSet<Currency *> *currencies = [NSOrderedSet orderedSetWithObject:[Currency createInContext:mainContext]];
    [wallet setCurrencies:currencies];
    return wallet;
}

@end
