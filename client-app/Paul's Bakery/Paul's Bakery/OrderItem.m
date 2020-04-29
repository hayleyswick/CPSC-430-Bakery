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
    [self setUserData];
    return self;
}
-(NSDictionary *)dictRepresentation {
    return @{@kOrderItemBatterType:self.batterType, @kOrderItemCakeType:self.cakeType, @kOrderItemQuantity:[NSNumber numberWithInt:self.quantity]};
}
-(BOOL)isEqual:(OrderItem *)i {
    return (self == i);
}
-(void)setUserData {
    if ([self.batterType isEqualToString:@BatterTypeVanilla]) {
        self.batterTypeText = @"Vanilla Batter";
    } else if ([self.batterType isEqualToString:@BatterTypeChocolate]) {
        self.batterTypeText = @"Chocolate Batter";
    }
    
    if ([self.cakeType isEqualToString:@CakeTypeQuarterSheet]) {
        self.cakeTypeText = @"1/4 Sheet";
    } else if ([self.cakeType isEqualToString:@CakeTypeHalfSheet]) {
        self.cakeTypeText = @"1/2 Sheet";
    } else if ([self.cakeType isEqualToString:@CakeTypeFullSheet]) {
        self.cakeTypeText = @"Full Sheet";
    } else if ([self.cakeType isEqualToString:@CakeTypeFullRound]) {
        self.cakeTypeText = @"Full Round";
    }
}
@end
