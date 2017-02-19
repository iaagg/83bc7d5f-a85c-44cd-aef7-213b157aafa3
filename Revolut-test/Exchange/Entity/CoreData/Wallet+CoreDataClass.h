
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Currency, User;

NS_ASSUME_NONNULL_BEGIN

@interface Wallet : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "Wallet+CoreDataProperties.h"
#import "NSManagedObject+Creating.h"
