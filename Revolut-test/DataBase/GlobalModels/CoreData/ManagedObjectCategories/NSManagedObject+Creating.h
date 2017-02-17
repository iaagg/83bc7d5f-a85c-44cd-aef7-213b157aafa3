
#import <CoreData/CoreData.h>

@interface NSManagedObject (Creating)

+ (instancetype)createInContext:(NSManagedObjectContext *)context;

@end
