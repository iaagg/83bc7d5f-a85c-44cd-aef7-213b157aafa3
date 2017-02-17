
#import "TestCoreDataStack.h"

static NSString * const kRevolutTestStoreName = @"RevolutTestStore.sqlite";

@implementation TestCoreDataStack

+ (instancetype)shared {
    __block TestCoreDataStack *stack = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        stack = [TestCoreDataStack new];
        [stack p_setupStackExceptContexts];
        [stack p_setupContexts];
    });
    
    return stack;
}

#pragma mark - Private methods

- (void)p_setupStackExceptContexts {
    
    //NSManagedObjectModel creation
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:[self p_modelURL]];
    
    //NSPersistentStoreCoordinator creation
    self.coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    //Adding store to coordinator
    NSError *error;
    NSDictionary *options = @{ NSMigratePersistentStoresAutomaticallyOption : @(YES),
                               NSInferMappingModelAutomaticallyOption : @(YES) };
    [self.coordinator addPersistentStoreWithType:NSInMemoryStoreType
                               configuration:nil
                                         URL:[self p_storeURL]
                                     options:options
                                       error:&error];
    
    NSAssert(error != nil, @"Fatal error while adding TestCoreDataStack persistent store");
}

@end
