
#import "NetworkClient.h"

static NSString * const kRevolutCurrenciesURL = @"http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml";
static NSTimeInterval const kRevolutDefaultRequestTimeout = 20;

@implementation NetworkClient

+ (instancetype)shared {
    static NetworkClient *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [NetworkClient new];
    });
    
    return instance;
}

- (void)requestCurrenciesWithSuccess:(void(^)(NSData *response))success failureHandler:(void(^)(NSError *error))failure {
    // Instantiate a session configuration object.
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.timeoutIntervalForRequest = kRevolutDefaultRequestTimeout;
    configuration.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    
    // Instantiate a session object.
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    
    NSURL *url = [NSURL URLWithString:kRevolutCurrenciesURL];
    
    // Create a data task object to perform the data downloading.
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error != nil) {
            // If any error occurs then just display its description on the console.
            NSLog(@"%@", [error localizedDescription]);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(error);
            });
        }
        else{
            // If no error occurs, check the HTTP status code.
            NSInteger HTTPStatusCode = [(NSHTTPURLResponse *)response statusCode];
            
            // If it's other than 200, then show it on the console.
            if (HTTPStatusCode != 200) {
                NSLog(@"HTTP status code = %ld", (long)HTTPStatusCode);
            }
            
            // Call the completion handler with the returned data on the main thread.
            dispatch_async(dispatch_get_main_queue(), ^{
                success(data);
            });
        }
    }];
    
    // Resume the task.
    [task resume];
}

@end
