//
//  Order.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/3/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderItem.h"
#import "Customer.h"

#define kOrderNumber "order_number"
#define kOrderItems "items"
#define kOrderNotes "notes"
#define kOrderCustomerID "customer_id"

@interface Order : NSObject

-(id)init;
-(id)initWithDict:(NSDictionary *)dict;
-(void)addItem:(OrderItem *)item;
-(void)removeItem:(OrderItem *)item;
-(NSDictionary *)dictRepresentation;

@property NSMutableArray *items;
@property int orderNumber;
@property NSString *notes;
@property Customer *customer;


@end
