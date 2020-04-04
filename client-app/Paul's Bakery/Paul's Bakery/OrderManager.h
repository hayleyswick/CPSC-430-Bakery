//
//  OrderManager.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/3/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Order.h"

@interface OrderManager : NSObject {
    NSMutableDictionary *orders;
}

@property (nonatomic, strong) Order *editingOrder;

-(id)init;
+(OrderManager *)sharedInstance;
-(void)addOrder:(Order *)o;
-(void)removeOrder:(Order *)o;
-(Order *)getOrderWithNumber:(int)orderNum;
-(NSArray *)getAllOrders;
-(int)count;


@end
