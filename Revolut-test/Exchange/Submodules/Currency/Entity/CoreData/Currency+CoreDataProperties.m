//
//  Currency+CoreDataProperties.m
//  Revolut-test
//
//  Created by Alexey Getman on 19/02/2017.
//  Copyright © 2017 AGG. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Currency+CoreDataProperties.h"

@implementation Currency (CoreDataProperties)

+ (NSFetchRequest<Currency *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Currency"];
}

@dynamic amount;
@dynamic symbol;
@dynamic title;

@end
