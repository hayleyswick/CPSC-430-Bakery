//
//  Inventory.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/27/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InventoryItem.h"

#define kInventoryItems "items"
#define kInventoryID "inventory_id"
#define kInventoryCountDate "count_date"

@interface Inventory : NSObject

@property NSMutableArray *items;
@property NSString *identifier;
@property NSDate *dateCounted;

-(id)init;
-(id)initWithDict:(NSDictionary *)dict;
-(NSDictionary *)dictRepresentation;
-(InventoryItem *)getItemWithIdentifier:(NSString *)identifier;
-(void)addItem:(InventoryItem *)i;
-(BOOL)isEqual:(Inventory *)i;

@end
