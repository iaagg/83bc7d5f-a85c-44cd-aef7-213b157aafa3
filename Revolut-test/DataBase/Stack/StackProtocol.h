
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@protocol StackProtocol <NSObject>

+ (instancetype)shared;

@property (strong, nonatomic) NSManagedObjectContext *mainQueueContext;

- (NSManagedObjectContext *)makeBackgroundContext;
- (void)saveMainContext;
- (void)saveBackgroundContext:(NSManagedObjectContext *)backgroundContext;

@end
