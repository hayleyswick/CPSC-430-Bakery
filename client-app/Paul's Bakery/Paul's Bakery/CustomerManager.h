//
//  CustomerManager.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/22/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomerManager : NSObject

@property NSMutableArray *customers;

-(id)init;
-(id)initWithCustomersDict:(NSDictionary *)dict;

@end
