
#import "NetworkClient.h"

//API
static NSString * const kRevolutCurrenciesURL = @"http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml";

//Settings
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
    
    //Session configuration
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.timeoutIntervalForRequest = kRevolutDefaultRequestTimeout;
    configuration.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    
    //Session
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    //Currencies rates API url
    NSURL *url = [NSURL URLWithString:kRevolutCurrenciesURL];
    
    //Session data task object to perform the data downloading.
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        //# If error received
        if (error != nil) {
            
            //Printing error into log
            NSLog(@"%@", [error localizedDescription]);
            
            //Call failure handler on main queue
            dispatch_async(dispatch_get_main_queue(), ^{
                if (failure) {
                    failure(error);
                }
            });
            
        //# Response and data received
        } else {
            
            //Checking the HTTP status code.
            NSInteger HTTPStatusCode = [(NSHTTPURLResponse *)response statusCode];
            
            //If code is not 200 -> print it into log
            if (HTTPStatusCode != 200) {
                NSLog(@"HTTP status code = %ld", (long)HTTPStatusCode);
            }
            
            //Call the success handler with the returned data on the main thread.
            dispatch_async(dispatch_get_main_queue(), ^{
                if (success) {
                    success(data);
                }
            });
        }
    }];
    
    // Resume the task.
    [task resume];
}

@end
