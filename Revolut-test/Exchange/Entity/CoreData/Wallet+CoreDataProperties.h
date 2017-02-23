
#import "Wallet+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Wallet (CoreDataProperties)

+ (NSFetchRequest<Wallet *> *)fetchRequest;

/*! @brief Currency to many ordered relation */
@property (nullable, nonatomic, retain) NSOrderedSet<Currency *> *currencies;

/*! @brief User relation */
@property (nullable, nonatomic, retain) User *user;

@end

@interface Wallet (CoreDataGeneratedAccessors)

- (void)insertObject:(Currency *)value inCurrenciesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromCurrenciesAtIndex:(NSUInteger)idx;
- (void)insertCurrencies:(NSArray<Currency *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeCurrenciesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInCurrenciesAtIndex:(NSUInteger)idx withObject:(Currency *)value;
- (void)replaceCurrenciesAtIndexes:(NSIndexSet *)indexes withCurrencies:(NSArray<Currency *> *)values;
- (void)addCurrenciesObject:(Currency *)value;
- (void)removeCurrenciesObject:(Currency *)value;
- (void)addCurrencies:(NSOrderedSet<Currency *> *)values;
- (void)removeCurrencies:(NSOrderedSet<Currency *> *)values;

@end

NS_ASSUME_NONNULL_END
