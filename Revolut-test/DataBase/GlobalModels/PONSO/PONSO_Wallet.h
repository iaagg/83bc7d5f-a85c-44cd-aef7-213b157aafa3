//
//  PONSO_Wallet.h
//  Revolut-test
//
//  Created by Alexey Getman on 19/02/2017.
//  Copyright © 2017 AGG. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PONSO_Currency, PONSO_User;

@interface PONSO_Wallet : NSObject

@property (weak, nonatomic) PONSO_User                  *user;
@property (strong, nonatomic) NSArray<PONSO_Currency *> *currencies;

@end
