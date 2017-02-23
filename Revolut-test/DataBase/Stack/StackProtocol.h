
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@protocol StackProtocol <NSObject>

+ (instancetype)shared;

@property (strong, nonatomic) NSManagedObjectContext *mainQueueContext;

/*!
 * @discussion Creates NSManagedObjectContext for background tasks
 * @return Private queue context for background tasks
 */
- (NSManagedObjectContext *)makeBackgroundContext;

/*!
 * @discussion Saves main queue context
 * @warning Should be used only if changes were performed in main queue context
 */
- (void)saveMainContext;

/*!
 * @discussion Saves tmp private queue context
 * @param backgroundContext TMP private queue context
 * @warning Should be used only if changes were performed in some private queue context
 */
- (void)saveBackgroundContext:(NSManagedObjectContext *)backgroundContext;

@end
