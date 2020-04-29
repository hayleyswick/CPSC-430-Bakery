//
//  Inventory.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/27/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "Inventory.h"

@implementation Inventory

-(id)init {
    self = [super init];
    self.items = [[NSMutableArray alloc] init];
    self.identifier = @"";
    return self;
}

-(id)initWithDict:(NSDictionary *)dict {
    self = [self init];
    for (NSDictionary *d in [dict objectForKey:@kInventoryItems]) {
        [self.items addObject:[[InventoryItem alloc] initWithDict:d]];
    }
    self.identifier = [dict objectForKey:@kInventoryID];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.dateCounted = [formatter dateFromString:[dict objectForKey:@kInventoryCountDate]];
    return self;
}

-(NSDictionary *)dictRepresentation {
    NSMutableArray *a = [[NSMutableArray alloc] init];
    for (InventoryItem *i in self.items) {
        [a addObject:[i dictRepresentation]];
    }
    return @{@kInventoryID:self.identifier, @kInventoryItems:a};
}

-(InventoryItem *)getItemWithIdentifier:(NSString *)identifier {
    for (InventoryItem *i in self.items) {
        if ([i.identifier isEqualToString:identifier]) {
            return i;
        }
    }
    InventoryItem *itm = [[InventoryItem alloc] init];
    itm.identifier = identifier;
    [self.items addObject:itm];
    return itm;
}
-(void)addItem:(InventoryItem *)i {
    [self.items addObject:i];
}
-(BOOL)isEqual:(Inventory *)i {
    return ([i.identifier isEqualToString:self.identifier]);
}
@end
