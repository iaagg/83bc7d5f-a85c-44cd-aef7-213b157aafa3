
#import "Currency+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Currency (CoreDataProperties)

+ (NSFetchRequest<Currency *> *)fetchRequest;

@property (nonatomic) int32_t amount;
@property (nullable, nonatomic, copy) NSString *symbol;
@property (nullable, nonatomic, copy) NSString *title;

@end

NS_ASSUME_NONNULL_END
