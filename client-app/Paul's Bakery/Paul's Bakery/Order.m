//
//  Order.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/3/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "Order.h"

@implementation Order

-(id)init {
    self = [super init];
    self.orderNumber = -1;
    items = [[NSMutableArray alloc] init];
    return self;
}
-(void)addItem:(OrderItem *)item {
    for (OrderItem *i in items) {
        if (i == item) {
            return;
        }
    }
    [items addObject:item];
}
-(void)removeItem:(OrderItem *)item {
    [items removeObject:item];
}
-(NSArray *)getItems {
    return items;
}
@end
