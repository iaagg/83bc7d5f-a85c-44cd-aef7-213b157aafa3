
#import <Foundation/Foundation.h>
@class PONSO_User;

@protocol ExchangeInteractorOutput <NSObject>

- (void)didFetchDefaultUser:(PONSO_User *)user;

@end
