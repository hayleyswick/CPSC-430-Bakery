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
    orders = [[NSMutableDictionary alloc] init];
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
    [orders setObject:o forKey:[NSNumber numberWithInt:o.orderNumber]];
}
-(void)removeOrder:(Order *)o {
    [orders removeObjectForKey:[NSNumber numberWithInt:o.orderNumber]];
}
-(Order *)getOrderWithNumber:(int)orderNum {
    return [orders objectForKey:[NSNumber numberWithInt:orderNum]];
}

-(int)count {
    return orders.count;
}
-(NSArray *)getAllOrders {
    NSMutableArray *a = [[NSMutableArray alloc] init];
    for (NSString *key in orders.allKeys) {
        [a addObject:[orders objectForKey:key]];
    }
    return [NSArray arrayWithArray:a];
}
@end
