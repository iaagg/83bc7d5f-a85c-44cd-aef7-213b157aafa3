//
//  User+CoreDataProperties.m
//  Revolut-test
//
//  Created by Alexey Getman on 19/02/2017.
//  Copyright © 2017 AGG. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "User+CoreDataProperties.h"

@implementation User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"User"];
}

@dynamic username;
@dynamic wallet;

@end
