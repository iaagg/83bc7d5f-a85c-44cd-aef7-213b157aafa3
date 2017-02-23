
#import <Foundation/Foundation.h>

@interface NetworkClient : NSObject

+ (instancetype)shared;

/*!
 * @discussion Async request to provided URL for fetching currencies rates
 * @param success success handler with received data
 * @param failure failure handler with received error
 */
- (void)requestCurrenciesWithSuccess:(void(^)(NSData *response))success failureHandler:(void(^)(NSError *error))failure;

@end
