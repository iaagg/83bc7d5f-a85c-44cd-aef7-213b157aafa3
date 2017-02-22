//
//  Currency+CoreDataProperties.h
//  Revolut-test
//
//  Created by Alexey Getman on 22/02/2017.
//  Copyright © 2017 AGG. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Currency+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Currency (CoreDataProperties)

+ (NSFetchRequest<Currency *> *)fetchRequest;

@property (nonatomic) double amount;
@property (nullable, nonatomic, copy) NSString *symbol;
@property (nullable, nonatomic, copy) NSString *title;

@end

NS_ASSUME_NONNULL_END
