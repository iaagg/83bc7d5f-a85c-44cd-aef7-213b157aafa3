
#import <Foundation/Foundation.h>
#import "CoreDataStack.h"

@interface TestCoreDataStack : CoreDataStack <StackProtocol>

/*!
 * @discussion Deletes from DB all entities of passed class
 * @param entitiesClass class of entities to be deleted
 * @warning Only for test usage
 */
- (void)deleteEntities:(Class)entitiesClass;

@end
