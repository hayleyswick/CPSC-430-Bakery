//
//  Order.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/3/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderItem.h"
#import "CustomerManager.h"

#define kOrderNumber "order_number"
#define kOrderNotes "notes"
#define kOrderCustomerID "customer_id"
#define kOrderItems "items"
#define kOrderDate "order_date"

@interface Order : NSObject

@property NSMutableArray *items;
@property int orderNumber;
@property NSString *notes;
@property Customer *customer;
@property NSDate *orderDate;

-(id)init;
-(id)initWithDict:(NSDictionary *)dict;
-(void)addItem:(OrderItem *)item;
-(void)removeItem:(OrderItem *)item;
-(NSDictionary *)dictRepresentation;
-(BOOL)isEqual:(Order *)o;


@end
