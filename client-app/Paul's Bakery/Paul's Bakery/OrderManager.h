//
//  OrderManager.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/3/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "Manager.h"
#import "Order.h"
#import "CustomerManager.h"

@protocol OrderManagerDelegate <NSObject>
@optional
-(void)orderDataDidUpdate:(NSArray *)orders;
-(void)orderWasAdded:(Order *)o;
@end

@interface OrderManager : Manager <CustomerManagerDelegate> {
    RESTQueryController *connectionAddOrder;
    RESTQueryController *connectionGetOrders;
}

@property (nonatomic, strong) id <OrderManagerDelegate> delegate;
@property (nonatomic, strong) Order *editingOrder;
@property NSMutableArray *orders;

-(id)init;
+(OrderManager *)sharedInstance;
-(void)addOrder:(Order *)o;
-(void)removeOrder:(Order *)o;
-(void)fetchOrders;


@end
