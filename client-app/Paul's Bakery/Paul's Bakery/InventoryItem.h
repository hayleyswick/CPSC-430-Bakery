//
//  InventoryItem.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/27/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kInventoryItemID "item_id"
#define kInventoryItemQuantity "quantity"

@interface InventoryItem : NSObject

@property NSString *identifier;
@property double quantity;

-(id)init;
-(id)initWithDict:(NSDictionary *)dict;
-(NSDictionary *)dictRepresentation;
-(BOOL)isEqual:(InventoryItem *)i;

@end
