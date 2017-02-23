
#import <Foundation/Foundation.h>
#import "StackProtocol.h"
#import "PrivateStackProtocol.h"

@interface CoreDataStack : NSObject <StackProtocol, PrivateStackProtocol>

//StackProtocol
@property (strong, nonatomic) NSManagedObjectContext        *mainQueueContext;

//PrivateStackProtocol
@property (strong, nonatomic) NSPersistentStoreCoordinator  *coordinator;

@end
