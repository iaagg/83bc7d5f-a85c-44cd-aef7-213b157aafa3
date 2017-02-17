
#import "CoreDataStack.h"

static NSString * const kRevolutCoreDataModelName = @"Revolut-test";
NSString * const kRevolutStoresDirectory = @"Stores";
static NSString * const kRevolutDefaultStoreName = @"RevolutStore.sqlite";

@interface CoreDataStack ()

@property (strong, nonatomic) NSManagedObjectContext        *privateSavingContext;

@end

@implementation CoreDataStack

+ (instancetype)shared {
    __block CoreDataStack *stack = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        stack = [CoreDataStack new];
        [stack p_setupStackExceptContexts];
        [stack p_setupContexts];
    });
    
    return stack;
}

- (NSManagedObjectContext *)makeBackgroundContext {
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    [context setParentContext:_mainQueueContext];
    return context;
}

- (void)saveMainContext {
    [self p_saveMainQueueContext];
}

- (void)saveBackgroundContext:(NSManagedObjectContext *)backgroundContext {
    if (backgroundContext.hasChanges) {
        [backgroundContext performBlockAndWait:^{
            NSError *error;
            [backgroundContext save:&error];
        }];
    }
    
    [self p_saveMainQueueContext];
}

#pragma mark - Private methods

- (void)p_setupStackExceptContexts {
    
    //NSManagedObjectModel creation
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:[self p_modelURL]];
    
    //NSPersistentStoreCoordinator creation
    _coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    //Adding store to coordinator
    NSError *error;
    NSDictionary *options = @{ NSMigratePersistentStoresAutomaticallyOption : @(YES),
                               NSInferMappingModelAutomaticallyOption : @(YES) };
    [_coordinator addPersistentStoreWithType:NSSQLiteStoreType
                               configuration:nil
                                         URL:[self p_storeURL]
                                     options:options
                                       error:&error];
    
    NSAssert(error != nil, @"Fatal error while adding CoreDataStack persistent store");
}

- (void)p_setupContexts {
    
    //Private context for saving setup
    _privateSavingContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    [_privateSavingContext setPersistentStoreCoordinator:_coordinator];
    
    //Main queue context setup
    _mainQueueContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_mainQueueContext setParentContext:_privateSavingContext];
}

- (NSURL *)p_modelURL {
    NSURL *url = [[NSBundle bundleForClass:[self class]] URLForResource:kRevolutCoreDataModelName withExtension:@"momd"];
    return url;
}

- (NSURL *)p_storeURL {
    NSURL *documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *storesURL = [documentsURL URLByAppendingPathComponent:kRevolutStoresDirectory];
    NSURL *defaultStoreURL = [storesURL URLByAppendingPathComponent:kRevolutDefaultStoreName];
    return defaultStoreURL;
}

- (void)p_saveMainQueueContext {
    if (_mainQueueContext.hasChanges) {
        [_mainQueueContext performBlockAndWait:^{
            NSError *error;
            [_mainQueueContext save:&error];
        }];
    }
    
    [self p_savePrivateSavingContext];
}

- (void)p_savePrivateSavingContext {
    if (_privateSavingContext.hasChanges) {
        [_privateSavingContext performBlock:^{
            NSError *error;
            [_privateSavingContext save:&error];
        }];
    }
}

@end
