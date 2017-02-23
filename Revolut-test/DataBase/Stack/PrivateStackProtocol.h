
#import <Foundation/Foundation.h>

/*
 
 This protocol is used for creating TestCoreDataStack, which inherits from CoreDataStack
 Methods and properties declared here used for overriding only necessary methods for testing
 
 */

@protocol PrivateStackProtocol <NSObject>

@property (strong, nonatomic) NSPersistentStoreCoordinator  *coordinator;

- (void)p_setupContexts;
- (NSURL *)p_modelURL;
- (NSURL *)p_storeURL;

@end
