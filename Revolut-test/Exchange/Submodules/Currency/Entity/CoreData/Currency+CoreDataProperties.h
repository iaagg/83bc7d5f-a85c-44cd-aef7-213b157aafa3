
#import "Currency+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Currency (CoreDataProperties)

+ (NSFetchRequest<Currency *> *)fetchRequest;

/*! @brief Amount of currency in user's wallet */
@property (nonatomic) double amount;

/*! @brief Unicode symbol of currency */
@property (nullable, nonatomic, copy) NSString *symbol;

/*! @brief Abbreviation uf currency */
@property (nullable, nonatomic, copy) NSString *title;

@end

NS_ASSUME_NONNULL_END
