
#import <XCTest/XCTest.h>
#import "TestCoreDataStack.h"
#import "User+CoreDataClass.h"
#import "Wallet+CoreDataClass.h"
#import "NSManagedObject+Creating.h"
#import "PONSO_User.h"
#import "PONSO_UserParser.h"

#define USER_NAME @"name"

@interface PONSO_UserParserTests : XCTestCase

@property (weak, nonatomic) TestCoreDataStack *coreDataStack;
@property (strong, nonatomic) User *user;

@end

@implementation PONSO_UserParserTests

- (void)setUp {
    [super setUp];
    _coreDataStack = [TestCoreDataStack shared];
    _user = [self p_setupDefaultUser];
}

- (void)tearDown {
    [super tearDown];
    _user = nil;
    [_coreDataStack deleteEntities:[User class]];
}

- (void)testAllPropertiesParsedToPONSO_User {
    PONSO_User *ponsoUser = [PONSO_UserParser parseCoreDataUser:_user];
    XCTAssertEqualObjects(ponsoUser.uuid, _user.uuid, @"ponsoUser uuid: %@ is NOT equal CoreData user uuid: %@", ponsoUser.uuid, _user.uuid);
    XCTAssertEqualObjects(ponsoUser.username, _user.username, @"ponsoUser username: %@ is NOT equal CoreData user username: %@", ponsoUser.username, _user.username);
    XCTAssertNotNil(ponsoUser.wallet, @"ponsoUser doesn't have wallet object");
}

#pragma mark - SETUP

- (User *)p_setupDefaultUser {
    NSManagedObjectContext *mainContext = _coreDataStack.mainQueueContext;
    User *defaultUser = [User createInContext:mainContext];
    [defaultUser setWallet:[Wallet createInContext:mainContext]];
    [defaultUser setUsername:USER_NAME];
    [defaultUser setUuid:[NSUUID UUID].UUIDString];
    [_coreDataStack saveMainContext];
    return defaultUser;
}

@end
