
#import <Foundation/Foundation.h>
#import "StackProtocol.h"
#import "PrivateStackProtocol.h"

@interface CoreDataStack : NSObject <StackProtocol, PrivateStackProtocol>

@property (strong, nonatomic) NSManagedObjectContext        *mainQueueContext;
@property (strong, nonatomic) NSPersistentStoreCoordinator  *coordinator;

@end
