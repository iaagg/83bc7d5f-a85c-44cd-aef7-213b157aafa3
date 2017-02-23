
#import <Foundation/Foundation.h>

@interface PONSO_Currency : NSObject

/*! @brief Amount of currency in user's wallet */
@property (assign, nonatomic) double   amount;

/*! @brief Unicode symbol of currency */
@property (strong, nonatomic) NSString  *symbol;

/*! @brief Abbreviation uf currency */
@property (strong, nonatomic) NSString  *title;

@end
