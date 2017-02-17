
#import <Foundation/Foundation.h>
#import "StackProtocol.h"

@interface StackFactory : NSObject

+ (id<StackProtocol>)stackForCurrentEnvironment;

@end
