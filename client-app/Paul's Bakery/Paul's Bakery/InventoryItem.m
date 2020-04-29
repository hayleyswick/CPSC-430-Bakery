//
//  InventoryItem.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/27/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "InventoryItem.h"

@implementation InventoryItem

-(id)init {
    self = [super init];
    self.identifier = @"";
    self.quantity = 0;
    return self;
}

-(id)initWithDict:(NSDictionary *)dict {
    self = [self init];
    self.identifier = [dict objectForKey:@kInventoryItemID];
    self.quantity = [[dict objectForKey:@kInventoryItemQuantity] doubleValue];
    return self;
}

-(NSDictionary *)dictRepresentation {
    return @{@kInventoryItemID:self.identifier, @kInventoryItemQuantity:[NSNumber numberWithDouble:self.quantity]};
}
-(BOOL)isEqual:(InventoryItem *)i {
    return ([i.identifier isEqualToString:self.identifier]);
}
@end
