
#import "Currency+CoreDataProperties.h"

@implementation Currency (CoreDataProperties)

+ (NSFetchRequest<Currency *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Currency"];
}

@dynamic amount;
@dynamic symbol;
@dynamic title;

@end
