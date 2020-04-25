//
//  OrderManager.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/3/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "OrderManager.h"

@implementation OrderManager

-(id)init {
    self = [super init];
    self.orders = [[NSMutableArray alloc] init];
    self.editingOrder = [[Order alloc] init];
    return self;
}
+(OrderManager *)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static OrderManager *sharedObject = nil;
    dispatch_once(&pred, ^{
        sharedObject = [[self alloc] init];
    });
    return sharedObject;
}
-(void)addOrder:(Order *)o {
    [BakeryCalculatorController sharedInstance].orderDelegate = self;
    [[BakeryCalculatorController sharedInstance] addOrder:o];
}
-(void)removeOrder:(Order *)o {
    
}


@end
