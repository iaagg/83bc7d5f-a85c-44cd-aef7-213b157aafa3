//
//  Wallet+CoreDataProperties.h
//  Revolut-test
//
//  Created by Alexey Getman on 19/02/2017.
//  Copyright © 2017 AGG. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Wallet+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Wallet (CoreDataProperties)

+ (NSFetchRequest<Wallet *> *)fetchRequest;

@property (nullable, nonatomic, retain) NSSet<Currency *> *currencies;
@property (nullable, nonatomic, retain) User *user;

@end

@interface Wallet (CoreDataGeneratedAccessors)

- (void)addCurrenciesObject:(Currency *)value;
- (void)removeCurrenciesObject:(Currency *)value;
- (void)addCurrencies:(NSSet<Currency *> *)values;
- (void)removeCurrencies:(NSSet<Currency *> *)values;

@end

NS_ASSUME_NONNULL_END
