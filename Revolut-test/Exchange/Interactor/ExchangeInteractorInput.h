
#import <Foundation/Foundation.h>
@class PONSO_User;

@protocol ExchangeInteractorInput <NSObject>

- (void)fetchDefaultUser;
- (void)savePonsoUser:(PONSO_User *)ponsoUser;

@end
