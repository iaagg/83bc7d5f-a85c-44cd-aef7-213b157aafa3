
#import "StackFactory.h"
#import "CoreDataStack.h"
#import "TestCoreDataStack.h"

@implementation StackFactory

+ (id<StackProtocol>)stackForCurrentEnvironment {
    id<StackProtocol> stack;
    BOOL isProductionEnvironment = PRODUCTION;
    
    if (isProductionEnvironment) {
        stack = [CoreDataStack shared];
    } else {
        stack = [TestCoreDataStack shared];
    }
    
    return stack;
}

@end
