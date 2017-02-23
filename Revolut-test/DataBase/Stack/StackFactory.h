
#import <Foundation/Foundation.h>
#import "StackProtocol.h"

@interface StackFactory : NSObject

/*!
 * @discussion Returns core data stack object according to ENV variable TESTING
                which is not nil in testing environment
 * @return Core data stack objects conforming StackProtocol protocol
 */
+ (id<StackProtocol>)stackForCurrentEnvironment;

@end
