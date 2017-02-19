
#import "NSManagedObject+Creating.h"

@implementation NSManagedObject (Creating)

+ (instancetype)createInContext:(NSManagedObjectContext *)context {
    NSString *name = NSStringFromClass(self);
    NSEntityDescription *description = [NSEntityDescription entityForName:name
                                                   inManagedObjectContext:context];
    NSManagedObject *createdObject = [NSEntityDescription insertNewObjectForEntityForName:description.name
                                                                   inManagedObjectContext:context];
    return createdObject;
}

@end
