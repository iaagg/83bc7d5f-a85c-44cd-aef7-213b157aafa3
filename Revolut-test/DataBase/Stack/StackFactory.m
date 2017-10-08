
#import "StackFactory.h"
#import "CoreDataStack.h"
#import "TestCoreDataStack.h"

@implementation StackFactory

+ (id<StackProtocol>)stackForCurrentEnvironment {
    id<StackProtocol> stack;
    if (PRODUCTION) {
        stack = [CoreDataStack shared];
    } else {
        stack = [TestCoreDataStack shared];
    }
    
    return stack;
}

@end
