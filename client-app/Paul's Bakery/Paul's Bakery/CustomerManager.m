//
//  CustomerManager.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/22/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "CustomerManager.h"

@implementation CustomerManager

-(id)init {
    self = [super init];
    self.customers = [[NSMutableArray alloc] init];
    return self;
}

-(id)initWithCustomersDict:(NSDictionary *)dict {
    self = [self init];
    
    return self;
}

@end
