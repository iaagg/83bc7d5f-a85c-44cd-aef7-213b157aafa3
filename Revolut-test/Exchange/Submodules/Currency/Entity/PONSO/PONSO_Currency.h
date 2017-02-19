
#import <Foundation/Foundation.h>

@interface PONSO_Currency : NSObject

@property (assign, nonatomic) int32_t   amount;
@property (strong, nonatomic) NSString  *symbol;
@property (strong, nonatomic) NSString  *title;

@end
