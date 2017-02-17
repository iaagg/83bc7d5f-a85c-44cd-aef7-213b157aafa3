
#import <Foundation/Foundation.h>

@protocol PrivateStackProtocol <NSObject>

@property (strong, nonatomic) NSPersistentStoreCoordinator  *coordinator;

- (void)p_setupContexts;
- (NSURL *)p_modelURL;
- (NSURL *)p_storeURL;

@end
