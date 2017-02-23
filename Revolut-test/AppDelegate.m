
#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [self p_postNotificationWithName:kRevolutAppDidBecomeActive];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [self p_postNotificationWithName:kRevolutAppWillResignActive];
}

#pragma mark - Private methods

- (void)p_postNotificationWithName:(NSNotificationName)name {
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil];
}

@end
