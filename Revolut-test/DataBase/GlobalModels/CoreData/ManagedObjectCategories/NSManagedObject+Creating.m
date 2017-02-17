
#import "NSManagedObject+Creating.h"

@implementation NSManagedObject (Creating)

+ (instancetype)createInContext:(NSManagedObjectContext *)context {
    NSEntityDescription *description = [NSEntityDescription entityForName:NSStringFromClass(self)
                                                   inManagedObjectContext:context];
    NSManagedObject *createdObject = [NSEntityDescription insertNewObjectForEntityForName:description.name
                                                                   inManagedObjectContext:context];
    return createdObject;
}

@end
