
#import <Foundation/Foundation.h>

@interface NetworkClient : NSObject

+ (instancetype)shared;

- (void)requestCurrenciesWithSuccess:(void(^)(NSData *response))success failureHandler:(void(^)(NSError *error))failure;

@end
