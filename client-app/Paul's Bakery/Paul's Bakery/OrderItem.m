//
//  OrderItem.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/3/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "OrderItem.h"

@implementation OrderItem

-(id)init {
    self = [super init];
    return self;
}
-(id)initWithDict:(NSDictionary *)dict {
    self = [self init];
    self.batterType = [dict objectForKey:@kOrderItemBatterType];
    self.cakeType = [dict objectForKey:@kOrderItemCakeType];
    self.quantity = [[dict objectForKey:@kOrderItemQuantity] doubleValue];
    return self;
}
-(NSDictionary *)dictRepresentation {
    return @{@kOrderItemBatterType:self.batterType, @kOrderItemCakeType:self.cakeType, @kOrderItemQuantity:[NSNumber numberWithInt:self.quantity]};
}
@end
