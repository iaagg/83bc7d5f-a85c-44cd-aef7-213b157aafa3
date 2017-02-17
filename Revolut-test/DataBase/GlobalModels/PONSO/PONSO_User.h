//
//  PONSO_User.h
//  Revolut-test
//
//  Created by Alexey Getman on 19/02/2017.
//  Copyright © 2017 AGG. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PONSO_Wallet;

@interface PONSO_User : NSObject

@property (strong, nonatomic) NSString      *username;
@property (strong, nonatomic) PONSO_Wallet  *wallet;

@end
