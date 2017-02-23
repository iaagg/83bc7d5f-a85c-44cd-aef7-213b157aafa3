
#import "User+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest;

/*! @brief Username of user */
@property (nullable, nonatomic, copy) NSString *username;

/*! @brief Unique id of user in db */
@property (nullable, nonatomic, copy) NSString *uuid;

/*! @brief Wallet object relation */
@property (nullable, nonatomic, retain) Wallet *wallet;

@end

NS_ASSUME_NONNULL_END
