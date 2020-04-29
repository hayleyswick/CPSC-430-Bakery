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
    self.items = [[NSMutableArray alloc] init];
    return self;
}
-(id)initWithDict:(NSDictionary *)dict {
    self = [self init];
    self.orderNumber = [[dict objectForKey:@kOrderNumber] intValue];
    self.notes = [dict objectForKey:@kOrderNotes];
    self.customer = [[CustomerManager sharedInstance] getCustomerWithID:[dict objectForKey:@kOrderCustomerID]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.orderDate = [formatter dateFromString:[dict objectForKey:@kOrderDate]];
    NSArray *a = [dict objectForKey:@kOrderItems];
    for (NSDictionary *d in a) {
        [self.items addObject:[[OrderItem alloc] initWithDict:d]];
    }
    return self;
}
-(void)addItem:(OrderItem *)item {
    for (OrderItem *i in self.items) {
        if (i == item) {
            return;
        }
    }
    [self.items addObject:item];
}
-(void)removeItem:(OrderItem *)item {
    [self.items removeObject:item];
}

-(NSDictionary *)dictRepresentation {
    NSMutableArray *a = [[NSMutableArray alloc] init];
    for (OrderItem *i in self.items) {
        [a addObject:[i dictRepresentation]];
    }
    return @{@kOrderNumber:[NSNumber numberWithInt:self.orderNumber], @kOrderItems:a, @kOrderNotes:self.notes, @kOrderCustomerID:self.customer.customerID};
}
-(BOOL)isEqual:(Order *)o {
    return (self.orderNumber == o.orderNumber);
}
@end
